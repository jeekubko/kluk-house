require "application_system_test_case"

class ExercisePlanItemsTest < ApplicationSystemTestCase
  setup do
    @exercise_plan_item = exercise_plan_items(:one)
  end

  test "visiting the index" do
    visit exercise_plan_items_url
    assert_selector "h1", text: "Exercise plan items"
  end

  test "should create exercise plan item" do
    visit exercise_plan_items_url
    click_on "New exercise plan item"

    fill_in "Exercise", with: @exercise_plan_item.exercise_id
    fill_in "Exercise plan", with: @exercise_plan_item.exercise_plan_id
    fill_in "Note", with: @exercise_plan_item.note
    fill_in "Reps", with: @exercise_plan_item.reps
    fill_in "Sets", with: @exercise_plan_item.sets
    fill_in "Weight", with: @exercise_plan_item.weight
    click_on "Create Exercise plan item"

    assert_text "Exercise plan item was successfully created"
    click_on "Back"
  end

  test "should update Exercise plan item" do
    visit exercise_plan_item_url(@exercise_plan_item)
    click_on "Edit this exercise plan item", match: :first

    fill_in "Exercise", with: @exercise_plan_item.exercise_id
    fill_in "Exercise plan", with: @exercise_plan_item.exercise_plan_id
    fill_in "Note", with: @exercise_plan_item.note
    fill_in "Reps", with: @exercise_plan_item.reps
    fill_in "Sets", with: @exercise_plan_item.sets
    fill_in "Weight", with: @exercise_plan_item.weight
    click_on "Update Exercise plan item"

    assert_text "Exercise plan item was successfully updated"
    click_on "Back"
  end

  test "should destroy Exercise plan item" do
    visit exercise_plan_item_url(@exercise_plan_item)
    accept_confirm { click_on "Destroy this exercise plan item", match: :first }

    assert_text "Exercise plan item was successfully destroyed"
  end
end
