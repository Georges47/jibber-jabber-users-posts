# syntax=docker/dockerfile:1

#1 This is the official Ruby image (https://hub.docker.com/_/ruby) - a complete Linux system with Ruby installed
FROM ruby:3.0.4

#2 Install applications needed for building Rails app
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

#3 The WORKDIR instruction sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD
# If a directory doesn’t exist, it will be created
WORKDIR /jibber-jabber-users-posts

#4 Copy files from current location to image WORKDIR
COPY Gemfile /jibber-jabber-users-posts/Gemfile
COPY Gemfile.lock /jibber-jabber-users-posts/Gemfile.lock

#5 Install gems in the image
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
