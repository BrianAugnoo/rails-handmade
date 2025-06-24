import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="anchor"
export default class extends Controller {
  static targets = ["anchor"]
  connect() {
    console.log("anchor");
    if (!this.hasAnchorTarget) return
    const target = this.anchorTarget;
    const container = document.querySelector(".scrollable");

    if (container && target) {
      console.log("scroll")
      container.scrollTo({ top: target.offsetTop })
    }
  }
}
