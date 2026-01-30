import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["dialog"]

    openIfDirty(event) {
        const prompt = this.element.querySelector('[name="exercise_plan[prompt]"]')?.value?.trim()

        // 1) prompt is mandatory
        if (!prompt) {
            event.preventDefault()
            alert("Please enter a prompt before generating with AI.")
            return
        }

        // 2) overwrite protection
        if (!this.isDirty()) return

        event.preventDefault()
        this.submitter = event.currentTarget
        this.dialogTarget.showModal()
    }

    proceed() {
        const btn = this.submitter
        this.submitter = null
        this.dialogTarget.close()
        btn.form.requestSubmit(btn) // keeps formaction to /generate
    }

    cancel() {
        this.submitter = null
        this.dialogTarget.close()
    }

    isDirty() {
        const name = this.element.querySelector('[name="exercise_plan[name]"]')?.value?.trim() || ""
        const description = this.element.querySelector('[name="exercise_plan[description]"]')?.value?.trim() || ""

        // Any nested item field filled? (exercise_id / sets / reps / weight / note)
        const itemFields = this.element.querySelectorAll(
            '[name^="exercise_plan[exercise_plan_items_attributes]"]'
        )

        const itemsDirty = Array.from(itemFields).some((el) => {
            // ignore hidden fields and Rails bookkeeping
            if (el.type === "hidden") return false

            // ignore unchecked destroy checkbox
            if (el.type === "checkbox") return el.checked

            // if it's a select, consider it dirty only if something is selected
            if (el.tagName === "SELECT") return (el.value || "").trim() !== ""

            // normal inputs/textareas
            return (el.value || "").trim() !== ""
        })

        return name.length > 0 || description.length > 0 || itemsDirty
    }

}
