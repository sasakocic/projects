require 'factory_bot_rails'

FactoryBot.define do
  factory :project do
    name { 'Project 1' }
    description { 'Description 1' }
    user { create(:user) }
  end
end
