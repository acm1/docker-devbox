#!/bin/bash -eu

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y curl vim mysql-client git build-essential tmux golang \
  autoconf bison libssl-dev libyaml-dev libreadline6 libreadline6-dev zlib1g \
  zlib1g-dev htop

# Install rbenv, ruby-build, and Ruby 1.9.3
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
/root/.rbenv/bin/rbenv install 1.9.3-p547
/root/.rbenv/bin/rbenv global 1.9.3-p547

# Install bundler
echo "gem: --no-rdoc --no-ri" >> ~/.gemrc
/root/.rbenv/shims/gem install bundler

# cleanup
apt-get clean
rm -rf /var/cache/apt/*
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
