

anchor { 'immerse::osgi::begin': }

$config = {
  'alias'                   => '/crx/server',
  'dav.create-absolute-uri' => false,
  'dav.protectedhandlers'   => 'org.apache.jackrabbit.server.remoting.davex.AclRemoveHandler',
}


aem::osgi::config { 'org.apache.sling.jcr.davex.impl.servlets.SlingDavExServlet' :
  ensure         => present,
  properties     => $config,
  handle_missing => 'remove',
  home           => '/opt/aem',
  type           => 'console',
  username       => 'admin',
  password       => $admin_password,
}

anchor { 'immerse::osgi::end': }

Anchor['immerse::aem::end']
-> Anchor['immerse::osgi::begin']
-> Aem::Osgi::Config['org.apache.sling.jcr.davex.impl.servlets.SlingDavExServlet']
-> Anchor['immerse::osgi::end']
