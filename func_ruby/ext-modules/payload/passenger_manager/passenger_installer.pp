package { 'rubygems-devel':
  ensure   => installed,
  name     => 'rubygems-devel',
  provider => 'dnf',
}
-> package { 'rubygem-rake':
  ensure   => installed,
  name     => 'rubygem-rake',
  provider => 'dnf',
}
-> package { 'ruby-devel':
  ensure   => installed,
  name     => 'ruby-devel',
  provider => 'dnf',
}
-> package { 'rubygem-rack':
  ensure   => installed,
  name     => 'rubygem-rack',
  provider => 'dnf',
}
-> package { 'alt-brepo-ruby33-devel':
  ensure   => installed,
  name     => 'alt-brepo-ruby33-devel',
  provider => 'dnf',
}
-> package { 'alt-brepo-ruby33-rubygem-rake':
  ensure   => installed,
  name     => 'alt-brepo-ruby33-rubygem-rake',
  provider => 'dnf',
}
-> package { 'passenger-devel':
  ensure   => installed,
  name     => 'passenger-devel',
  provider => 'dnf',
}
-> package { 'passenger':
  ensure   => installed,
  name     => 'passenger',
  provider => 'dnf',
}
-> package { 'nginx-passenger':
  ensure   => installed,
  name     => 'nginx-mod-http-passenger',
  provider => 'dnf',
}
-> file { 'passenger.conf':
  ensure  => file,
  path    => '/etc/nginx/conf.d/passenger.conf',
  content => 'passenger_root /usr/share/ruby/vendor_ruby/phusion_passenger/locations.ini;
passenger_ruby /usr/bin/ruby;
passenger_instance_registry_dir /var/run/passenger-instreg;
passenger_user_switching on;
passenger_env_var PASSENGER_COMPILE_NATIVE_SUPPORT_BINARY 0;
passenger_env_var PASSENGER_DOWNLOAD_NATIVE_SUPPORT_BINARY 0;',
}
-> file { 'passenger_includer.conf':
  ensure  => file,
  content => 'load_module modules/ngx_http_passenger_module.so;',
  path    => '/etc/nginx/conf.d/main/passenger.conf',
}
~> service { 'nginx_service':
  ensure     => running,
  name       => 'nginx',
  provider   => 'systemd',
  hasrestart => true,
}
