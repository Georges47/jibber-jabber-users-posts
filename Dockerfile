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

#ENV POSTGRES_HOST ${POSTS_DB_HOST}
#ENV POSTGRES_USER ${POSTS_DB_USER}
#ENV POSTGRES_PASSWORD ${POSTS_DB_PASSWORD}

RUN #rm -f tmp/pids/server.pid

#RUN rails db:create rails db:migrate

#COPY entrypoint.sh /posts/
RUN chmod +x /posts/entrypoint.sh
ENTRYPOINT ["/posts/entrypoint.sh"]

CMD ["rails", "server", "-p", "8080", "-b", "0.0.0.0"]

#ENTRYPOINT ["rails", "db:create", "rails", "db:migrate", "&&","rails", "server", "-p", "8080", "-b", "0.0.0.0"]
