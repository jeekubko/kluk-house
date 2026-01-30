require "json"

SCHEMAS = {
  exercise_plan: JSON.parse(
    File.read(Rails.root.join("config/schemas/exercise_plan.json"))
  )
}.freeze