class AddIsSystemExerciseToExercises < ActiveRecord::Migration[7.1]
  def change
    add_column :exercises, :is_system_exercise, :boolean, null: false, default: false
    change_column_null :exercises, :user_id, true
  end
end
