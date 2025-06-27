import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="close"
export default class extends Controller {
  static targets = ["alert"]
  destroy() {
    this.alertTarget.remove()
  }
}
