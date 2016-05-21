FROM golang:latest

MAINTAINER Matt Fellows <m@onegeek.com.au>

RUN apt-get update
RUN apt-get install -y curl patch gawk g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev unzip zip sudo
RUN useradd -ms /bin/bash app && \
  usermod -g root app && \
  chmod g+w /
RUN echo "app ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER app
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
RUN /bin/bash -l -c "curl -L get.rvm.io | bash -s stable"
RUN /bin/bash -l -c "rvm install 2.1.5"
RUN /bin/bash -l -c "echo 'gem: --no-ri --no-rdoc' > ~/.gemrc"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"
ENV GOPATH /go
RUN echo "PATH=$GOPATH/bin:/usr/local/go/bin:$PATH" >> ~/.bashrc
