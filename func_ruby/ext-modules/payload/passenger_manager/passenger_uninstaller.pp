package { 'nginx-mod-http-passenger':
  ensure   => absent,
  name     => 'nginx-mod-http-passenger',
  provider => 'dnf',
}
-> package { 'passenger-devel':
  ensure   => absent,
  name     => 'passenger-devel',
  provider => 'dnf',
}
-> package { 'passenger':
  ensure   => absent,
  name     => 'passenger',
  provider => 'dnf',
}
-> file { 'passenger.conf':
  ensure => absent,
  path   => '/etc/nginx/conf.d/passenger.conf',
}
-> file { 'passenger_includer.conf':
  ensure => absent,
  path   => '/etc/nginx/conf.d/main/passenger.conf',
}
~> service { 'nginx_service':
  ensure     => running,
  name       => 'nginx',
  provider   => 'systemd',
  hasrestart => true,
}
