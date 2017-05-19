anchor { 'immerse::packages::begin': }

aem::crx::package { 'acs-aem-commons' :
  ensure      => installed,
  home        => '/opt/aem',
  password    => $admin_password,
  pkg_group   => 'adobe/consulting',
  pkg_name    => 'acs-aem-commons-content',
  pkg_version => '3.6.2',
  source      => '/vagrant/files/acs-aem-commons-content.zip',
  type        => 'api',
  username    => 'admin'
}

anchor { 'immerse::packages::end': }

Anchor['immerse::sling::end']
-> Anchor['immerse::packages::begin']
-> Aem::Crx::Package['acs-aem-commons']
-> Anchor['immerse::packages::end']