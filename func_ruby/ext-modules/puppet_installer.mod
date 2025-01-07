#!/opt/brepo/ruby33/bin/ruby

require "shell"
require "date"

class PuppetWorker < Kernel::ModuleCoreWorker
  MODULE_ID = "puppet_installer"

  def info
    {
      ID: 1,
      NAME: MODULE_ID,
      DESCR: "Added puppet support, needed for another modules",
      REQ: "",
      CONF: "",
    }
  end

  def enable
    log_file = get_log
    date = DateTime.now
    bkp_name = date.strftime("%Y_%m_%d_%H_%M_%S")
    if !check
      inf = info
      log("Req error, needed #{inf[:REQ]}")
      "Req error, needed #{inf[:REQ]}"
    else
      Shell.def_system_command("dnf", "/usr/bin/dnf")
      Shell.def_system_command("gem", "/usr/bin/gem")
      Shell.verbose = true
      Shell.debug = false
      sh = Shell.new
      begin
        %x( /usr/bin/rpm -q puppet )
        unless $?.success?
          log("install puppet packages")
          sh.transact do
            dnf("install", "-y", "puppet", "ruby", "rubygems", "puppet-stdlib") > log_file
            gem("cleanup", "thor") > log_file
          end
        else
          log("puppet installed")
        end
        log("prepare puppet configuration")
        if File.exist?("/etc/puppet/puppet.conf")
          File.rename("/etc/puppet/puppet.conf", "/etc/puppet/puppet.conf.#{bkp_name}")
        end
        puppet_conf = <<~CONF
          [main]
          confdir=/etc/puppet
          logdir=/var/log/puppet
          vardir=/var/lib/puppet
          ssldir=/var/lib/puppet/ssl
          rundir=/var/run/puppet
          factpath=$confdir/facter
          environmentpath=$confdir/environments
          basemodulepath=/usr/share/puppet/modules
          default_manifest=$confdir/manifests
          environment_timeout = unlimited
          manifests_path =$confdir/manifests
        CONF
        File.open("/etc/puppet/puppet.conf", "w") do |f|
          f.puts(puppet_conf)
        end
        log("prepare hiera configuration")
        if File.exist?("/etc/puppet/hiera.yaml")
          File.rename("/etc/puppet/hiera.yaml", "/etc/puppet/hiera.yaml.#{bkp_name}")
        end
        hiera_conf = <<~CONF
          ---
          version: 5
          hierarchy:
          - name: "yaml"
            datadir: /tmp/puppet/hieradata
            # data is staged to a local directory by the puppet-manifest-apply.sh script
            data_hash: yaml_data
            paths:
              - runtime.yaml
              - host.yaml
              - secure_system.yaml
              - system.yaml
              - secure_static.yaml
              - static.yaml
              - personality.yaml
              - global.yaml
        CONF
        File.open("/etc/puppet/hiera.yaml", "w") do |f|
          f.puts(hiera_conf)
        end
        log("create manifests directory")
        sh.transact do
          ((mkdir("/etc/puppet/manifests")) > log_file) unless File.exist?("/etc/puppet/manifests")
        end
        super
      rescue => e
        log("module installation error #{e.message} #{e.backtrace.first}")
        "module installation error. See log #{log_file}"
      end
    end
  end

  implements IPluginInterface
end

module PuppetModule
  def get_object
    Proc.new { PuppetWorker.new }
  end

  module_function :get_object
end

class Kernel::PluginConfiguration
  include PuppetModule

  @@loaded_plugins[PuppetWorker::MODULE_ID] = PuppetModule.get_object
end
