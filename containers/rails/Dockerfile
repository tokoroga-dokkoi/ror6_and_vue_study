FROM ruby:2.6.5

# YARN install
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# Common Library
RUN apt-get update -qq &&  \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       postgresql \
                       qt5-default \
                       libqt5webkit5-dev \
                       gstreamer1.0-plugins-base \
                       gstreamer1.0-tools \
                       gstreamer1.0-x \
                       yarn \
                       libjpeg-dev \
                       libpng-dev \
                       imagemagick \
                       apt-transport-https

# mkdir application directory
RUN mkdir /webapp
WORKDIR /webapp

# Copy Gemfile and Gemfile.lock to container
ADD Gemfile /webapp/Gemfile
ADD Gemfile.lock /webapp/Gemfile.lock
RUN bundle install 

# All file copy
ADD . /webapp

# puma.sock
RUN mkdir -p tmp/sockets

