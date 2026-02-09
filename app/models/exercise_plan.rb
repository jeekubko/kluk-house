class ExercisePlan < ApplicationRecord
  validates :name, presence: true
  validate :at_least_one_item_with_exercise
  attr_accessor :prompt

  belongs_to :user

  has_many :exercise_plan_items, dependent: :destroy, inverse_of: :exercise_plan, validate: true

  accepts_nested_attributes_for :exercise_plan_items, allow_destroy: true, reject_if: :all_blank

  private

  def at_least_one_item_with_exercise
    valid_items = exercise_plan_items.reject(&:marked_for_destruction?).select { |item| item.exercise_id.present? }

    return if valid_items.any?

    errors.add(:base, "Add at least one exercise item to the plan")
  end

end
