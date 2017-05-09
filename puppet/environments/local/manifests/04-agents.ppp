anchor { 'immerse::agents::begin': }

aem::agent::replication::publish { 'Publish Agent' :
  home           => '/opt/aem',
  log_level      => 'error',
  name           => 'publish',
  password       => $admin_password,
  runmode        => 'author',
  trans_password => $admin_password,
  trans_uri      => 'http://localhost:4503/publish/bin/receive?authRequestLogin=1',
  trans_user     => 'admin',
  username       => 'admin',
}

aem::agent::replication::flush { 'Flush Agent' :
  description    => 'Some Custom Text',
  home           => '/opt/aem',
  name           => 'flush',
  password       => $admin_password,
  runmode        => 'author',
  trans_password => $admin_password,
  trans_uri      => 'http://localhost:80/dispatcher/invalidate.cache',
  trans_user     => 'admin',
  username       => 'admin',
}

aem::agent::replication::reverse { 'Reverse Agent' :
  enabled  => false,
  home     => '/opt/aem',
  name     => 'publish_reverse',
  password => $admin_password,
  runmode  => 'author',
  username => 'admin',
}

aem::agent::replication { 'Test and Target' :
  ensure   => absent,
  home     => '/opt/aem',
  name     => 'test_and_target',
  password => $admin_password,
  runmode  => 'author',
  username => 'admin',
}

anchor { 'immerse::agents::end': }

Anchor['immerse::osgi::end']
-> Anchor['immerse::agents::begin']
-> Aem::Agent::Replication::Publish['Publish Agent']
-> Aem::Agent::Replication::Flush['Flush Agent']
-> Aem::Agent::Replication::Reverse['Reverse Agent']
-> Aem::Agent::Replication['Test and Target']
-> Anchor['immerse::agents::end']