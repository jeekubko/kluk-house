module Gemini
  class ExercisePlanGenerator
    def initialize(user:, preferences:)
      @user = user
      @preferences = preferences
    end

    def call
      exercises = allowed_exercises
      prompt = build_prompt(exercises)

      raw_response = Gemini::Client.generate(prompt)
      text = extract_text(raw_response)

      plan = parse_json(text)
      #validate!(plan, exercises)

      plan
    end

    private

    def allowed_exercises
      Exercise.select(:id, :name, :muscle_group)
    end

    def build_prompt(exercises)
      <<~PROMPT
        Create a workout plan based on:
        #{@preferences}

        Use ONLY these exercises (by id):
        #{exercises.map { |e| "#{e.id}: #{e.name}" }.join("\n")}

        Follow the provided schema and return JSON only.
      PROMPT
    end

    def extract_text(response)
      response.dig("candidates", 0, "content", "parts", 0, "text")
    end

    def parse_json(text)
      JSON.parse(text.gsub(/```json|```/i, "").strip)
    end

    def validate!(plan, exercises)
      valid_ids = exercises.map(&:id)
      plan["sessions"].each do |s|
        s["items"].each do |item|
          raise "Invalid exercise_id" unless valid_ids.include?(item["exercise_id"])
        end
      end
    end
  end
end
