#!/bin/bash
set -e
set -x

# Install system deps for puppet stuffs
sudo apt-get install -y puppet ruby ruby-dev wget unzip

# Install Librarian
sudo gem install --no-ri --no-rdoc librarian-puppet

# Use Librarian to pull down modules and puppet apply
librarian-puppet install
sudo puppet apply --hiera_config hiera.yaml --verbose --debug --modulepath=modules manifests/site.pp
