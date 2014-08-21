FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y vim
RUN apt-get install -y mysql-client
RUN apt-get install -y git
RUN apt-get install -y build-essential
RUN apt-get install -y tmux
RUN apt-get install -y golang
RUN apt-get install -y autoconf
RUN apt-get install -y bison
RUN apt-get install -y libssl-dev
RUN apt-get install -y libyaml-dev
RUN apt-get install -y libreadline6
RUN apt-get install -y libreadline6-dev
RUN apt-get install -y zlib1g
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y htop

# Install rbenv, ruby-build, and Ruby 1.9.3
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
RUN echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN /root/.rbenv/bin/rbenv install 1.9.3-p547
RUN /root/.rbenv/bin/rbenv global 1.9.3-p547

# Install bundler
RUN echo "gem: --no-rdoc --no-ri" >> ~/.gemrc
RUN /root/.rbenv/shims/gem install bundler

# cleanup
RUN apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

CMD ["tmux"]
