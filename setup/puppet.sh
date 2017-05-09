#!/bin/bash

echo 'Starting Puppet VM Provisioning'

# Install puppet
echo 'Puppet VM Provisioning: Installing puppet.'
rpm -Uvh http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum -y install puppet

echo 'PATH=$PATH:/opt/puppetlabs/bin' >> ~/.bash_profile
echo 'export PATH' >> ~/.bash_profile
. ~/.bash_profile

gem install librarian-puppet --no-document

# Install puppet modules.
echo 'Puppet VM Provisioning: Installing puppet modules.'
#rm -Rf /vagrant/puppet/.librarian
#rm -Rf /vagrant/puppet/.tmp
if [ -f /vagrant/puppet/Puppetfile.lock ]; then
  rm /vagrant/setup/Puppetfile.lock
fi

# Install gems for Puppet
cd /vagrant/setup
librarian-puppet install --path /vagrant/puppet/modules

# Install encryption for demo.
/opt/puppetlabs/puppet/bin/gem install hiera-eyaml
echo 'Finished basic VM Provisioning.'

# Puppet Command (modules dir is different per boot; check 'vagrant up' logs).
# puppet apply --modulepath '/tmp/vagrant-puppet/modules-0babbbfe2b8141099d7779d6ec4f93d6:/etc/puppet/modules' --detailed-exitcodes --environmentpath /tmp/vagrant-puppet/environments/ --environment local /tmp/vagrant-puppet/environments/local/manifests --debug
