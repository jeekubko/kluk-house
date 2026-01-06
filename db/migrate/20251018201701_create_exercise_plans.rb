class CreateExercisePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :exercise_plans do |t|
      t.string :name
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
