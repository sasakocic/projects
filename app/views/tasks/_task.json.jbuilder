json.extract! task, :id, :name, :description, :project_id, :member_id, :status, :created_at, :updated_at
json.url task_url(task, format: :json)
