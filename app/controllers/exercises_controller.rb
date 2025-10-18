class ExercisesController < ApplicationController
  before_action :set_exercise, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  # GET /exercises or /exercises.json
  def index
    @exercises = Exercise.all
  end

  # GET /exercises/1 or /exercises/1.json
  def show
  end

  # GET /exercises/new
  def new
    @exercise = Exercise.new
  end

  # GET /exercises/1/edit
  def edit
  end

  # POST /exercises or /exercises.json
  def create
    @exercise = current_user.exercises.build(exercise_params)

    respond_to do |format|
      if @exercise.save
        format.html do
          redirect_to @exercise, notice: 'Exercise was successfully created.'
        end
        format.json { render :show, status: :created, location: @exercise }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @exercise.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /exercises/1 or /exercises/1.json
  def update
    respond_to do |format|
      if @exercise.update(exercise_params)
        format.html do
          redirect_to @exercise,
                      notice: 'Exercise was successfully updated.',
                      status: :see_other
        end
        format.json { render :show, status: :ok, location: @exercise }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json do
          render json: @exercise.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /exercises/1 or /exercises/1.json
  def destroy
    @exercise.destroy!

    respond_to do |format|
      format.html do
        redirect_to exercises_path,
                    notice: 'Exercise was successfully destroyed.',
                    status: :see_other
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_exercise
    @exercise = Exercise.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def exercise_params
    params.require(:exercise).permit(:name, :description, :muscle_group)
  end
end
