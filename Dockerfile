FROM ruby:3.0.0

RUN apt-get update && apt-get -y install nodejs

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["/usr/local/bin/bundle", "exec", "rails", "server", "--binding=0.0.0.0"]