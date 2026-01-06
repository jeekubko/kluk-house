class Exercise < ApplicationRecord
  belongs_to :user, optional: true

  enum muscle_group: {
         chest: 'chest',
         back: 'back',
         shoulders: 'shoulders',
         arms: 'arms',
         legs: 'legs',
         core: 'core'
       },
       _prefix: true

  scope :by_system_flag, ->(value) do
    value.present? ? where(is_system_exercise: value) : all
  end

  scope :by_muscle_group, ->(muscle) do
    muscle.present? ? where(muscle_group: muscle) : all
  end

  has_many :exercise_plan_items, dependent: :nullify, inverse_of: :exercise
end
