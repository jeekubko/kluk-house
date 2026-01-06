json.extract! exercise_plan_item, :id, :exercise_plan_id, :exercise_id, :sets, :reps, :weight, :note, :created_at, :updated_at
json.url exercise_plan_item_url(exercise_plan_item, format: :json)
