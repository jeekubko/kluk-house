class MakeExerciseNullableInExercisePlanItems < ActiveRecord::Migration[7.1]
  def change
    change_column_null :exercise_plan_items, :exercise_id, true
  end
end
