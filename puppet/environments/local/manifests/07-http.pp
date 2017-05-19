


anchor { 'immerse::dispatcher::begin': }

class { 'aem::dispatcher' :
  decline_root      => 'off',
  dispatcher_name   => 'Immerse Demo',
  log_file          => '/etc/httpd/logs/immerse_dispatcher.log',
  log_level         => 'debug',
  module_file       => '/vagrant/files/dispatcher.so',
  use_processed_url => 'on',
  pass_error        => '400-404',
}

aem::dispatcher::farm { 'immerse' :
  docroot => '/var/www/vhosts/immerse',
  renders => {
    'hostname'       => 'localhost',
    'port'           => 4502,
  },
  filters => [
    { 'type' => 'deny', 'path' => '/*', },
    { 'type' => 'deny', 'path' => '/apps',      'rank' => 310, },
    { 'type' => 'deny', 'path' => '/system',    'rank' => 311, },
    { 'type' => 'deny', 'path' => '/crx',       'rank' => 301, },
    { 'type' => 'allow', 'url' => '/content*',  'rank' => 300, }
  ],
}

anchor { 'immerse::dispatcher::end': }

Anchor['immerse::packages::end']
-> Anchor['immerse::dispatcher::begin']
-> Class['aem::dispatcher']
-> Anchor['immerse::dispatcher::end']