require 'factory_bot_rails'

FactoryBot.define do
  factory :task do
    sequence(:id) { |n| n }
    name { "Task #{id}" }
    description { "Description #{id}" }
    project { create(:project, user: create(:user, email: "user#{id}@example.com")) }
    member { create(:member) }
    status { 'Done' }
  end
end
