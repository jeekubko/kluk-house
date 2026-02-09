class AddNotNullConstraintsToExercisePlanAndExercise < ActiveRecord::Migration[7.1]
  def up
    # 1. Backfill existing NULL values
    execute <<~SQL
      UPDATE exercise_plans
      SET name = 'Unnamed plan'
      WHERE name IS NULL;
    SQL

    execute <<~SQL
      UPDATE exercises
      SET muscle_group = 'unknown'
      WHERE muscle_group IS NULL;
    SQL

    # 2. Add NOT NULL constraints
    change_column_null :exercise_plans, :name, false
    change_column_null :exercises, :muscle_group, false
  end

  def down
    # Rollback: allow NULLs again
    change_column_null :exercise_plans, :name, true
    change_column_null :exercises, :muscle_group, true
  end
end
