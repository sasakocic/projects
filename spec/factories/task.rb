require 'factory_bot_rails'

FactoryBot.define do
  factory :task do
    id = FactoryBot.generate(:random_id)
    name { "Task #{id}" }
    description { "Description #{id}" }
    project { create(:project, user: create(:user, password: 'password', email: "user#{id}@example.com")) }
    member { create(:member) }
    status { 'Done' }
  end
end
