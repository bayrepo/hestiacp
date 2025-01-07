#!/opt/brepo/ruby33/bin/ruby

def load_ruby_options_defaults
  hestiacp_ruby_func_path = "/usr/local/hestia/func_ruby"
  $LOAD_PATH.unshift hestiacp_ruby_func_path
  hestiacp_ruby_gem_version = "3.3.0"
  Gem.paths = {
    "GEM_HOME" => "#{hestiacp_ruby_func_path}/gems/ruby/#{hestiacp_ruby_gem_version}",
    "GEM_PATH" => "#{hestiacp_ruby_func_path}/gems/ruby/#{hestiacp_ruby_gem_version}",
  }
end

def load_hestia_default_path_from_env
  return ENV["HESTIA"] if ENV.key? "HESTIA"
  "/usr/local/hestia"
end
