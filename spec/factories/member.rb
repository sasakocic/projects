require 'factory_bot_rails'

FactoryBot.define do
  sequence(:random_id) { |n| n }

  factory :member do
    id = FactoryBot.generate(:random_id)
    name { "Member #{id}" }
    email { "member#{id}@example.com" }
    description { "Description #{id}" }
    user { create(:user, password: 'password') }
  end
end
