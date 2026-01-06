module ExercisesHelper
  def muscle_group_options
    Exercise.muscle_groups.keys.map { |key| [key.humanize, key] }
  end

  def exercise_filter_tabs(system_value:, muscle_group:)
    tabs = [
      { label: "All",    value: nil},
      { label: "System", value: "true"},
      { label: "Mine",   value: "false"}
    ]

    tabs.map do |tab|
      active = (system_value == tab[:value]) || (system_value.blank? && tab[:value].nil?)

      link_to tab[:label],
        exercises_path(system: tab[:value], muscle_group: muscle_group),
        class: tab_class(active)
    end.join.html_safe
  end

  private

  def tab_class(active)
    base = "px-3 py-2 rounded-md text-sm font-medium"
    active ? "#{base} bg-white shadow" : "#{base} text-gray-700 hover:bg-gray-50"
  end
end
