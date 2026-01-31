import { Controller } from "@hotwired/stimulus"

// Handles Rails nested fields (add/remove) without refresh.
// - Adds new items from a <template>
// - Removes existing items by checking the hidden _destroy checkbox and hiding the row
export default class extends Controller {
  static targets = ["items", "template"]

  add(event) {
    event.preventDefault()

    const html = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, String(Date.now()))
    this.itemsTarget.insertAdjacentHTML("beforeend", html)
  }

  remove(event) {
    event.preventDefault()

    const itemEl = event.target.closest("[data-nested-form-item]")
    if (!itemEl) return

    // If it's an existing record, mark _destroy and hide
    const destroyInput = itemEl.querySelector('input[name*="[_destroy]"]')
    if (destroyInput) {
      destroyInput.checked = true
    }

    itemEl.classList.add("hidden")
  }
}
