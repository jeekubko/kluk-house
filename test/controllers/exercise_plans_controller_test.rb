require "test_helper"

class ExercisePlansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exercise_plan = exercise_plans(:one)
  end

  test "should get index" do
    get exercise_plans_url
    assert_response :success
  end

  test "should get new" do
    get new_exercise_plan_url
    assert_response :success
  end

  test "should create exercise_plan" do
    assert_difference("ExercisePlan.count") do
      post exercise_plans_url, params: { exercise_plan: { description: @exercise_plan.description, name: @exercise_plan.name, user_id: @exercise_plan.user_id } }
    end

    assert_redirected_to exercise_plan_url(ExercisePlan.last)
  end

  test "should show exercise_plan" do
    get exercise_plan_url(@exercise_plan)
    assert_response :success
  end

  test "should get edit" do
    get edit_exercise_plan_url(@exercise_plan)
    assert_response :success
  end

  test "should update exercise_plan" do
    patch exercise_plan_url(@exercise_plan), params: { exercise_plan: { description: @exercise_plan.description, name: @exercise_plan.name, user_id: @exercise_plan.user_id } }
    assert_redirected_to exercise_plan_url(@exercise_plan)
  end

  test "should destroy exercise_plan" do
    assert_difference("ExercisePlan.count", -1) do
      delete exercise_plan_url(@exercise_plan)
    end

    assert_redirected_to exercise_plans_url
  end
end
