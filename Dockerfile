FROM ruby:2.6.3

ENV BUNDLER_VERSION 2.0.2

RUN apt-get update

# Configure the main working directory. This is the base 
# directory used in any further RUN, COPY, and ENTRYPOINT 
# commands.
RUN mkdir -p /app 
WORKDIR /app

# Copy the Gemfile as well as the Gemfile.lock and install 
# the RubyGems. This is a separate step so the dependencies 
# will be cached unless changes to one of those two files 
# are made.
COPY Gemfile Gemfile.lock ./ 
RUN gem install bundler:${BUNDLER_VERSION} \
     && bundle install --jobs 20 --retry 5

# Copy the main application.
COPY . ./
