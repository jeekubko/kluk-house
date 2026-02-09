class Exercise < ApplicationRecord
  validates :name, :muscle_group, presence: true
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

  def self.user_exercises(user)
    user.exercises.or(Exercise.where(is_system_exercise: true))
  end

  def self.most_popular(number = 1)
    where(is_system_exercise: true)
      .left_joins(:exercise_plan_items)
      .group(:id)
      .order(Arel.sql("COUNT(exercise_plan_items.id) DESC"))
      .limit(number)
  end

  has_many :exercise_plan_items, dependent: :destroy, inverse_of: :exercise
end
