class CreateExercisePlanItems < ActiveRecord::Migration[7.1]
  def change
    create_table :exercise_plan_items do |t|
      t.references :exercise_plan,
                   null: false,
                   foreign_key: {
                     on_delete: :cascade
                   }
      t.references :exercise, null: false, foreign_key: true
      t.integer :sets
      t.integer :reps
      t.float :weight
      t.text :note

      t.timestamps
    end
  end
end
