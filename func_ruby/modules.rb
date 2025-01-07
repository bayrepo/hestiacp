#!/opt/brepo/ruby33/bin/ruby

require "main"
require "interface"
require "json"
require "csv"
require "date"

IPluginInterface = interface do
  required_methods :info, :key, :enable, :disable, :log, :command
end

class Kernel::PluginConfiguration
  attr_accessor :key_readed
  CONF_PATH = "#{$HESTIA}/conf/ext-modules.conf"
  MODULES_PATH = "#{$HESTIA}/func_ruby/ext-modules"
  KEY_FILE_PATH = "#{$HESTIA}/func_ruby/ext-modules/api.key"
  MODULES_DATA_PATH = "#{$HESTIA}/func_ruby/ext-modules/payload"
  MODULES_CONF_PATH = "#{$HESTIA}/func_ruby/ext-modules/configs"

  @@loaded_plugins = {}

  def get_loaded_plugins
    @@loaded_plugins
  end

  def not_implemented
    raise "Not Implemented"
  end

  def key_file_create
    g_key = (0...10).map { ("0".."9").to_a[rand(10)] }.join
    begin
      f = File.new(KEY_FILE_PATH, File::CREAT | File::WRONLY, 0o600)
      f.write(g_key)
      f.close
    rescue => e
      hestia_print_error_message_to_cli "Error with ext-modules key file creation #{e.message} #{e.backtrace.first}"
      log_event E_PERMISSION, $ARGUMENTS
      exit(1)
    end
    g_key
  end

  def generate_key
    hestia_check_privileged_user
    if File.exist?(KEY_FILE_PATH)
      if (File.stat(KEY_FILE_PATH).mode & 0xFFF).to_s(8) != "600"
        File.unlink(KEY_FILE_PATH)
        key_file_create
      end
    else
      key_file_create
    end
    begin
      f = File.open(KEY_FILE_PATH)
      result = f.gets
      f.close
      raise "incorrect length" if result.nil? || result.length != 10
      result.chomp
    rescue => e
      File.unlink(KEY_FILE_PATH) if File.exist?(KEY_FILE_PATH)
      key_file_create
    end
  end

  def initialize
    @key_readed = generate_key
  end

  @@loaded_plugins["default"] = :not_implemented
end

class Kernel::ModuleCoreWorker
  ACTION_OK = ""

  def key
    begin
      File.open(Kernel::PluginConfiguration::KEY_FILE_PATH) do |f|
        result = f.gets.chomp
        return result
      end
    rescue
      ""
    end
  end

  def get_log
    "#{$HESTIA}/log/#{self.class::MODULE_ID}.log"
  end

  def log(format, *args)
    return if $HESTIA.nil?

    log_file = "#{$HESTIA}/log/#{self.class::MODULE_ID}.log"
    date = DateTime.now
    log_time = date.strftime("%Y-%m-%d %T")
    log_time = "#{log_time} #{File.basename($PROGRAM_NAME)}"
    out_result = format % args

    File.append! log_file, "#{log_time} #{out_result}"
  end

  def log_return(format, *args)
    log(format, *args)
    format % args
  end

  def check
    result = self.info
    if result[:REQ] == "" || result[:REQ].nil?
      true
    else
      reqs = result[:REQ].split(",")
      full_result = true
      reqs.each do |mname|
        nm = mname.strip
        if hestia_ext_module_state_in_conf(nm, :get) == "disabled"
          full_result = false
        end
      end
      full_result
    end
  end

  def enable
    log("#{self.class::MODULE_ID} enabled")
    ACTION_OK
  end

  def disable
    log("#{self.class::MODULE_ID} disabled")
    ACTION_OK
  end

  def get_module_paydata_dir()
    "#{Kernel::PluginConfiguration::MODULES_DATA_PATH}/#{self.class::MODULE_ID}/"
  end

  def get_module_paydata(file_path)
    dir = get_module_paydata_dir
    "#{dir}#{file_path}"
  end

  def get_module_conf(file_path)
    "#{Kernel::PluginConfiguration::MODULES_CONF_PATH}/#{self.class::MODULE_ID}/#{file_path}"
  end

  def command(args)
    log("#{self.class::MODULE_ID} execute commands with args #{args}")
    ACTION_OK
  end
end

class PluginManager
  def initialize(default_plugin = "default")
    @default_plugin = default_plugin
    @config = PluginConfiguration.new
    @loaded_modules = {}
  end

  def get_loaded_plugins
    @config.get_loaded_plugins
  end

  def get_key
    @config.key_readed
  end

  def get_instance(plugin_name)
    plugin_handler = case get_loaded_plugins[plugin_name]
      when Symbol
        @config.method(get_loaded_plugins[plugin_name])
      when Proc
        get_loaded_plugins[plugin_name]
      else
        @config.method(get_loaded_plugins[@default_plugin])
      end
    plugin_handler.call
  end

  def load_plugins(filter = nil, list = nil)
    Dir.glob("#{PluginConfiguration::MODULES_PATH}/*.mod").each do |f|
      if File.exist?(f) && !File.directory?(f) && File.stat(f).uid.zero? && !@loaded_modules.include?(f)
        begin
          process_file = true
          process_f = File.basename(f, ".mod")
          if !list.nil? && filter.nil?
            result = list.split(",").map do |nm|
              nm1 = nm.strip
              File.basename(nm1, ".mod")
            end
            process_file = result.include? process_f unless result.nil?
          else
            process_file = (process_f.match? Regexp.new(filter)) unless filter.nil?
          end
          f_name = File.basename(f, ".mod").gsub("-", "_")
          eval "module PluginsContainer_#{f_name}; end"
          eval "load f, PluginsContainer_#{f_name} if process_file"
          @loaded_modules[f] = 1
        rescue => e
          hestia_print_error_message_to_cli "Module loading #{f}: #{e.message} #{e.backtrace.first}"
          log_event E_INVALID, $ARGUMENTS
          exit(1)
        end
      end
    end
  end
end

def hestia_ext_module_state_in_conf(module_id, action = :get)
  case action
  when :get
    return "disabled" unless File.exist?(Kernel::PluginConfiguration::CONF_PATH)
    File.open(Kernel::PluginConfiguration::CONF_PATH, File::RDONLY) do |fl|
      fl.flock(File::LOCK_SH)
      fl.each do |line|
        res = line.split("=", 2)
        if res.length > 1
          if res[0].strip == module_id.to_s
            return "enabled" if res[1].strip == "enabled"
            break
          end
        end
      end
    end
    return "disabled"
  when :enable
    begin
      File.open(Kernel::PluginConfiguration::CONF_PATH, File::RDWR | File::CREAT, 0o600) do |fl|
        fl.flock(File::LOCK_EX)
        strings = []
        fl.each do |line|
          res = line.split("=", 2)
          if res.length > 1
            unless res[0].strip == module_id.to_s
              strings << line
            end
          end
        end
        strings << "#{module_id}=enabled"
        fl.truncate(0)
        fl.rewind
        strings.each { |str| fl.puts(str) }
      end
      return "enabled"
    rescue => e
      hestia_print_error_message_to_cli "problem with config file #{e.message} #{e.backtrace.first}"
      log_event E_INVALID, $ARGUMENTS
      exit(1)
    end
  when :disable
    begin
      File.open(Kernel::PluginConfiguration::CONF_PATH, File::RDWR | File::CREAT, 0o600) do |fl|
        fl.flock(File::LOCK_EX)
        strings = []
        fl.each do |line|
          res = line.split("=", 2)
          if res.length > 1
            unless res[0].strip == module_id.to_s
              strings << line
            end
          end
        end
        strings << "#{module_id}=disabled"
        fl.truncate(0)
        fl.rewind
        strings.each { |str| fl.puts(str) }
      end
      return "disabled"
    rescue => e
      hestia_print_error_message_to_cli "problem with config file #{e.message} #{e.backtrace.first}"
      log_event E_INVALID, $ARGUMENTS
      exit(1)
    end
  else
    hestia_print_error_message_to_cli "incorrect module state #{module_id} - #{action.to_s}"
    log_event E_INVALID, $ARGUMENTS
    exit(1)
  end
end
