# Project Management - Plannerly

<p>
   <a href="https://github.com/sasakocic/projects/actions"><img alt="test status" src="https://github.com/sasakocic/projects/workflows/CI/badge.svg"></a>
</p>

## Description

Rails application that allows logged-in users to create projects and tasks within them and assigning them to team members.

## Database model

```
users
    id
    email

projects
    id: autonumber
    name: string
    description: text
    user: references user
    created_at
    updated_at

tasks
    id
    name
    description
    project: references project
    member: references member
    created_at
    updated_at

members
    id
    name
    email
    description
    user: references user
    created_at
    updated_at
```

* Ruby version

3.0.0

* System dependencies

        PostgreSQL

* Configuration

        brew install libpq # on MacOS
        # on ubuntu sudo apt-get install libpq-dev
        brew install openssl
        gem install bindex -- --with-cppflags=-I/opt/homebrew/opt/openssl@1.1/include
        gem install puma -- --with-cppflags=-I/opt/homebrew/opt/openssl@1.1/include

* Database creation

```bash
gem install bundler
bundle install --jobs 4 --retry 3
bundle exec rake db:create
bundle exec rake db:schema:load
```

* Database initialization

```bash
bundle
brew install postgresql
createuser -s postgres
createdb demo_development
rails db:migrate
```

* How to run the test suite

Just run

        createdb project_test # only once
        bundle exec rspec

* Services

  - postgreSQL database

* Deployment instructions

  - create a database

      sudo -u postgres psql
      postgres=# create database project_test;
      postgres=# create user projects with encrypted password 'projects';
      postgres=# grant all privileges on database project_test to postgres;

  - bundle exec rails server

## Setup

```bash
rvm use ruby-3.0.0
rails new projects
gem install rspec
gem install rubocop
gem install simplecov
bundle add devise
rails g devise:install
rails g devise user
rake db:migrate
rails g scaffold project name description:text user:references
rake db:migrate
rails g scaffold member name email description:text user:references
# rails g scaffold status name description:text
rails generate scaffold task name description:text project:references member:references status
heroku stack:set heroku-20 # downgrade from 22 because of ruby-3.0.0
```

### Documentation

- [Changelog](./CHANGELOG.md)
- [License](./LICENSE)
- [Rubocop Style Guide](https://github.com/rubocop/ruby-style-guide)
- [Contributing](./CONTRIBUTING.md)