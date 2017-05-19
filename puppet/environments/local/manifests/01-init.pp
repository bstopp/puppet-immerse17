# Default settings
File {
  ignore => '.svn',
  source_permissions => ignore,
  backup             => false,
}

Package {
  allow_virtual => false,
}

Exec {
  path => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
}

service { 'firewalld' :
  ensure => stopped,
  enable => false,
}

anchor{ 'immerse::init::begin': }

# Java Configurations
java::oracle { 'jdk8' :
  ensure        => 'present',
  version_major => '8u112',
  version_minor => 'b15',
  java_se       => 'jdk'
}

file { '/opt/aem' :
  ensure => directory,
  mode   => '0777',
  owner  => 'vagrant',
  group  => 'vagrant'
}
file { '/opt/aem/license.properties' :
  ensure => file,
  mode   => '0644',
  source => '/vagrant/files/license.properties'
}

$apache_dirs = [ '/var/www', '/var/www/vhosts', ]

file { $apache_dirs :
  ensure => directory,
  owner  => 'root',
  group  => 'root',
  mode   => '0775',
  before => Class['apache'],
}

class { 'apache' :
  default_confd_files => false,
  default_mods        => false,
  default_vhost       => false,
  purge_vhost_dir     => true,
  vhost_dir           => '/etc/httpd/vhost.d',
}

apache::vhost { 'immerse.localhost' :
  custom_fragment => '

  <IfModule disp_apache2.c>
    SetHandler dispatcher-handler
  </IfModule>
',
  default_vhost   => true,
  docroot         => '/var/www/vhosts/immerse',
  port            => '80',
  request_headers => ['unset Authorization'],
}

include apache::mod::rewrite
include apache::mod::deflate

class { 'apache::mod::info' :
  restrict_access => false,
}

$admin_password = lookup('aem::admin::password')

anchor{ 'immerse::init::end': }

include ::ruby::dev

Anchor['immerse::init::begin']
-> Java::Oracle['jdk8']
-> File['/opt/aem/license.properties']
-> Anchor['immerse::init::end']

Anchor['immerse::init::begin']
-> Class['apache']
-> Anchor['immerse::init::end']
