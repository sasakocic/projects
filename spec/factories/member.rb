require 'factory_bot_rails'

FactoryBot.define do
  factory :member do
    sequence(:id) { |n| n }
    name { "Member #{id}" }
    email { "member#{id}@example.com" }
    description { "Description #{id}" }
    user { create(:user, email: "user#{id}@example.com") }
  end
end
