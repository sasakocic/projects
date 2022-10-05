json.extract! member, :id, :name, :email, :description, :user_id, :created_at, :updated_at
json.url member_url(member, format: :json)
