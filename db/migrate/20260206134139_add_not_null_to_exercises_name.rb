class AddNotNullToExercisesName < ActiveRecord::Migration[7.1]
  def change
    change_column_null :exercises, :name, false
  end
end
