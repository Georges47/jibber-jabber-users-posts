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

COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

CMD ["rails", "server", "-p", "8080", "-b", "0.0.0.0"]
