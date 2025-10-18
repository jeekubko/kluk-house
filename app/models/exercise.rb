class Exercise < ApplicationRecord
  belongs_to :user

  enum muscle_group: {
         chest: 'chest',
         back: 'back',
         shoulders: 'shoulders',
         arms: 'arms',
         legs: 'legs',
         core: 'core'
       },
       _prefix: true

  # has_many :workout_exercises, dependent: :restrict_with_error
end
