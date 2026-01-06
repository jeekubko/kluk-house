require "application_system_test_case"

class ExercisePlansTest < ApplicationSystemTestCase
  setup do
    @exercise_plan = exercise_plans(:one)
  end

  test "visiting the index" do
    visit exercise_plans_url
    assert_selector "h1", text: "Exercise plans"
  end

  test "should create exercise plan" do
    visit exercise_plans_url
    click_on "New exercise plan"

    fill_in "Description", with: @exercise_plan.description
    fill_in "Name", with: @exercise_plan.name
    fill_in "User", with: @exercise_plan.user_id
    click_on "Create Exercise plan"

    assert_text "Exercise plan was successfully created"
    click_on "Back"
  end

  test "should update Exercise plan" do
    visit exercise_plan_url(@exercise_plan)
    click_on "Edit this exercise plan", match: :first

    fill_in "Description", with: @exercise_plan.description
    fill_in "Name", with: @exercise_plan.name
    fill_in "User", with: @exercise_plan.user_id
    click_on "Update Exercise plan"

    assert_text "Exercise plan was successfully updated"
    click_on "Back"
  end

  test "should destroy Exercise plan" do
    visit exercise_plan_url(@exercise_plan)
    accept_confirm { click_on "Destroy this exercise plan", match: :first }

    assert_text "Exercise plan was successfully destroyed"
  end
end
