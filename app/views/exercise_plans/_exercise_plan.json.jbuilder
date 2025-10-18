json.extract! exercise_plan, :id, :name, :description, :user_id, :created_at, :updated_at
json.url exercise_plan_url(exercise_plan, format: :json)
