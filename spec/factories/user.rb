require 'factory_bot_rails'

FactoryBot.define do
  sequence(:random_email_id) { |n| n }

  factory :user do
    id = FactoryBot.generate(:random_email_id)
    email { "user#{id}@example.com" }
  end
end
