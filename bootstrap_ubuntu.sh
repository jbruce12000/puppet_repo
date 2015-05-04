#!/bin/bash
set -e
set -x

# Install system deps for puppet stuffs
sudo apt-get install -y puppet ruby ruby-dev wget unzip

# Install Librarian
if sudo gem list|grep librarian-puppet; then
  echo "OK skipping gem install librarian-puppet"
else
  echo "OK installing librarian-puppet"
  sudo gem install --no-ri --no-rdoc librarian-puppet
fi

# Use Librarian to pull down modules and puppet apply
sudo librarian-puppet install
sudo puppet apply --hiera_config hiera.yaml --verbose --debug --modulepath=modules manifests/site.pp
