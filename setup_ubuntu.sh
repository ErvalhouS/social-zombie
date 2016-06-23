#! /bin/bash

#The script is assuming you have curl and git installed already on Ubuntu 12.04+

#install ruby via RVM (ruby version manager)
curl -sSL https://get.rvm.io | bash -s $1
source /usr/local/rvm/scripts/rvm
rvm install ruby-2.3.1
rvm use ruby-2.3.1

#install postgresql
sudo apt-get install -y postgresql postgresql-contrib libpq-dev

#create role in database
sudo -u postgres bash -c "psql -c \"CREATE ROLE $USER LOGIN;\""

#install redis
sudo apt-get install -y redis

#install memcached
sudo apt-get install -y memcached

#install nodejs javascript runtime
sudo apt-get install -y nodejs npm

#install foreman
apt-get -y install ca-certificates
sudo wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb

sudo echo "deb http://deb.theforeman.org/ precise 1.11" > /etc/apt/sources.list.d/foreman.list
sudo echo "deb http://deb.theforeman.org/ plugins 1.11" >> /etc/apt/sources.list.d/foreman.list
sudo apt-get -y install ca-certificates
sudo wget -q https://deb.theforeman.org/pubkey.gpg -O- | apt-key add -

sudo apt-get update && apt-get -y install foreman-installer
sudo foreman-installer

#install bundler
gem install bundler

#install gems
bundle install

#migrate database
bundle exec rake db:setup

#launch app
foreman start
