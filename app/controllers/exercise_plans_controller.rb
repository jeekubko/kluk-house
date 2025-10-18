class ExercisePlansController < ApplicationController
  before_action :set_exercise_plan, only: %i[show edit update destroy]

  # GET /exercise_plans or /exercise_plans.json
  def index
    @exercise_plans = ExercisePlan.all
  end

  # GET /exercise_plans/1 or /exercise_plans/1.json
  def show
  end

  # GET /exercise_plans/new
  def new
    @exercise_plan = ExercisePlan.new
  end

  # GET /exercise_plans/1/edit
  def edit
  end

  # POST /exercise_plans or /exercise_plans.json
  def create
    @exercise_plan = current_user.exercise_plans.build(exercise_plan_params)

    respond_to do |format|
      if @exercise_plan.save
        format.html do
          redirect_to @exercise_plan,
                      notice: 'Exercise plan was successfully created.'
        end
        format.json { render :show, status: :created, location: @exercise_plan }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @exercise_plan.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /exercise_plans/1 or /exercise_plans/1.json
  def update
    respond_to do |format|
      if @exercise_plan.update(exercise_plan_params)
        format.html do
          redirect_to @exercise_plan,
                      notice: 'Exercise plan was successfully updated.',
                      status: :see_other
        end
        format.json { render :show, status: :ok, location: @exercise_plan }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json do
          render json: @exercise_plan.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /exercise_plans/1 or /exercise_plans/1.json
  def destroy
    @exercise_plan.destroy!

    respond_to do |format|
      format.html do
        redirect_to exercise_plans_path,
                    notice: 'Exercise plan was successfully destroyed.',
                    status: :see_other
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_exercise_plan
    @exercise_plan = ExercisePlan.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def exercise_plan_params
    params.require(:exercise_plan).permit(:name, :description)
  end
end
