FROM debian:jessie

# ADD build.sh /tmp/
# RUN bash /tmp/build.sh
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y curl vim mysql-client git build-essential tmux golang \
  autoconf bison libssl-dev libyaml-dev libreadline6 libreadline6-dev zlib1g \
  zlib1g-dev htop procps traceroute man-db sudo openjdk-7-jdk
RUN groupadd -g 1000 dev && \
    useradd -u 1000 -g 1000 -m -c 'dev user' -s /bin/bash dev && \
    echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER dev
ENV HOME /home/dev

# Install rbenv, ruby-build, and Ruby 1.9.3
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
RUN echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN ~/.rbenv/bin/rbenv install 1.9.3-p547
RUN ~/.rbenv/bin/rbenv global 1.9.3-p547

# Install bundler
RUN echo "gem: --no-rdoc --no-ri" >> ~/.gemrc
RUN ~/.rbenv/shims/gem install bundler

CMD ["tmux"]
