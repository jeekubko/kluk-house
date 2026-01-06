require "test_helper"

class ExercisePlanItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exercise_plan_item = exercise_plan_items(:one)
  end

  test "should get index" do
    get exercise_plan_items_url
    assert_response :success
  end

  test "should get new" do
    get new_exercise_plan_item_url
    assert_response :success
  end

  test "should create exercise_plan_item" do
    assert_difference("ExercisePlanItem.count") do
      post exercise_plan_items_url, params: { exercise_plan_item: { exercise_id: @exercise_plan_item.exercise_id, exercise_plan_id: @exercise_plan_item.exercise_plan_id, note: @exercise_plan_item.note, reps: @exercise_plan_item.reps, sets: @exercise_plan_item.sets, weight: @exercise_plan_item.weight } }
    end

    assert_redirected_to exercise_plan_item_url(ExercisePlanItem.last)
  end

  test "should show exercise_plan_item" do
    get exercise_plan_item_url(@exercise_plan_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_exercise_plan_item_url(@exercise_plan_item)
    assert_response :success
  end

  test "should update exercise_plan_item" do
    patch exercise_plan_item_url(@exercise_plan_item), params: { exercise_plan_item: { exercise_id: @exercise_plan_item.exercise_id, exercise_plan_id: @exercise_plan_item.exercise_plan_id, note: @exercise_plan_item.note, reps: @exercise_plan_item.reps, sets: @exercise_plan_item.sets, weight: @exercise_plan_item.weight } }
    assert_redirected_to exercise_plan_item_url(@exercise_plan_item)
  end

  test "should destroy exercise_plan_item" do
    assert_difference("ExercisePlanItem.count", -1) do
      delete exercise_plan_item_url(@exercise_plan_item)
    end

    assert_redirected_to exercise_plan_items_url
  end
end
