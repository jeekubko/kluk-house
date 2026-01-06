class ExercisePlanItem < ApplicationRecord
  belongs_to :exercise_plan, inverse_of: :exercise_plan_items
  belongs_to :exercise, inverse_of: :exercise_plan_items
end
