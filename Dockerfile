FROM ruby:2.7.1-slim-buster

RUN apt-get update && apt-get install -qq -y --no-install-recommends build-essential ruby-dev nodejs nano libpq-dev imagemagick curl gnupg

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -qq -y yarn

RUN gem install bundler

ENV INSTALL_PATH /ac_vale

RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH
COPY Gemfile ./

ENV BUNDLE_PATH /gems

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

COPY . .