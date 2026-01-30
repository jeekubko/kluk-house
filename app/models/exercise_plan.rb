class ExercisePlan < ApplicationRecord
  attr_accessor :prompt

  belongs_to :user

  has_many :exercise_plan_items, dependent: :destroy, inverse_of: :exercise_plan

  accepts_nested_attributes_for :exercise_plan_items,
                                allow_destroy: true,
                                reject_if: :all_blank
end
