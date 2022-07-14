FROM ruby:3.0.4-alpine

RUN apk add --update --no-cache --virtual run-dependencies \
		build-base \
		postgresql-client \
		postgresql-dev \
		yarn \
		git \
		tzdata \
		libpq \
		&& rm -rf /var/cache/apk/*
		
WORKDIR /posts

COPY Gemfile Gemfile.lock /posts/ 

RUN bundle install

COPY . /posts/

ENTRYPOINT []

#EXPOSE 8081
#RUN rm -f tmp/pids/server.pid && rails db:create db:migrate && rails s -p 8081 -b '0.0.0.0'