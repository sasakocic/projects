# Project Management

## Description

Make a rails app to handle projects and tasks.
A logged-in user can create projects, create tasks on it and assign the tasks to people.
Please feel free to add any functionality as per your choice
**We would love to see some tests

So logged-in user creates projects and tasks within projects. He assigns the tasks to members.
Members could be part of a team.

users
    id
    name
    email

projects
    id: autonumber
    name: string
    description: text
    owner: references user
    created_at
    updated_at

tasks
    id
    name
    description
    project: references project
    assignee: references member
    created_at
    updated_at

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

3.0.0

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Setup

```bash
brew install openssl
gem install bindex -- --with-cppflags=-I/opt/homebrew/opt/openssl@1.1/include
gem install puma -- --with-cppflags=-I/opt/homebrew/opt/openssl@1.1/include
rvm use ruby-3.0.0
rails new projects
gem install rspec
gem install rubocop
gem install simplecov
bundle add devise
rails g devise:install
rails g devise user
rake db:migrate
```