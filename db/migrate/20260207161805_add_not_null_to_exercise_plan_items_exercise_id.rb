class AddNotNullToExercisePlanItemsExerciseId < ActiveRecord::Migration[7.1]
  def up
    # 🔒 Safety check – fail fast if bad data exists
    if execute("SELECT 1 FROM exercise_plan_items WHERE exercise_id IS NULL LIMIT 1").any?
      raise ActiveRecord::IrreversibleMigration,
            "exercise_plan_items contains rows with NULL exercise_id. Fix data before migrating."
    end

    change_column_null :exercise_plan_items, :exercise_id, false
  end

  def down
    change_column_null :exercise_plan_items, :exercise_id, true
  end
end
