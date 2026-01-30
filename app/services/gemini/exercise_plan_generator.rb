module Gemini
  class ExercisePlanGenerator
    def initialize(user:, preferences:)
      @user = user
      @preferences = preferences
    end

    def call
      exercises = allowed_exercises
      prompt = build_prompt(exercises)

      3.times do 
        raw_response = Gemini::Client.generate(prompt)
        text = extract_text(raw_response)
        plan = parse_json(text)
        
        puts validate(plan)
        puts plan
        return plan if validate(plan)
      end

      false
    end

    private

    def allowed_exercises
      Exercise.user_exercises(@user).map do |exercise|
        {
          id: exercise.id,
          name: exercise.name,
          muscle_group: exercise.muscle_group
        }
      end
    end

    def build_prompt(exercises)
      <<~PROMPT
        Create a workout plan based on:
        #{@preferences}

        Use ONLY these exercises:
        #{exercises}

        Follow the provided schema and return JSON only.
      PROMPT
    end

    def extract_text(response)
      response.dig("candidates", 0, "content", "parts", 0, "text")
    end

    def parse_json(text)
      JSON.parse(text.gsub(/```json|```/i, "").strip)
    end

    def validate_schema(json)
      JSON::Validator.validate(SCHEMAS[:exercise_plan], json)
    end

    def validate_exercise_ids(json)
      gemini_exercise_ids = json['exercise_plan_items_attributes'].map { |e| e['exercise_id'] }.uniq
      user_exercise_ids = Exercise.user_exercises(@user).ids

      diff = gemini_exercise_ids - user_exercise_ids

      diff.empty?
    end

    # Here you can add more content validations
    def validate_content(json)
      validate_exercise_ids(json)
    end

    def validate(json)
      validate_schema(json) && validate_content(json)
    end

  end
end
