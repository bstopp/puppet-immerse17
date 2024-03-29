
# AEM Instances

$log_config = {
  'pid'                                      => 'org.apache.sling.commons.log.LogManager',
  'properties' => {
    'org.apache.sling.commons.log.level'       => 'warn',
    'org.apache.sling.commons.log.file'        => 'logs/error.log',
    'org.apache.sling.commons.log.file.number' => 7,
    'org.apache.sling.commons.log.file.size'   => "'.'yyyy-MM-dd",
    'org.apache.sling.commons.log.pattern'     => '{0,date,dd.MM.yyyy HH:mm:ss.SSS} *{4}* [{2}] {3} {5}',
    'org.apache.sling.commons.log.numOfLines'  => 10000
  }
}

$author_osgi = [
  {
    'org.apache.jackrabbit.oak.plugins.blob.datastore.FileDataStore-Author' => {
      'pid'  => 'org.apache.jackrabbit.oak.plugins.blob.datastore.FileDataStore',
      'properties' => {
        'path' => 'crx-quickstart/repository/datastore'
      }
    }
  },
  {
    'org.apache.jackrabbit.oak.plugins.segment.SegmentNodeStoreService-Author' => {
      'pid'             => 'org.apache.jackrabbit.oak.plugins.segment.SegmentNodeStoreService',
      'properties' => {
        'customBlobStore' => true
      }
    }
  },
  {
    'org.apache.sling.commons.log.LogManager-Author' => $log_config
  }
]

anchor { 'immerse::aem::begin': }

aem::instance { 'aem' :
  debug_port      => 30303,
  home            => '/opt/aem',
  jvm_mem_opts    => '-Xmx2048m',
  manage_home     => false,
  osgi_configs    => $author_osgi,
  port            => 4502,
  runmodes        => ['localdev', 'local'],
  sample_content  => true,
  source          => '/vagrant/files/aem-quickstart.jar',
  timeout         => 1200,
  type            => 'author',
  version         => '6.2.0',
}

anchor { 'immerse::aem::end': }

Anchor['immerse::aem::begin']
-> Aem::Instance['aem']
-> Anchor['immerse::aem::end']
