import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="animation"
export default class extends Controller {
  static targets = ["dropItem"]
  connect() {
    console.log("get out!")
  }

  dropdown(event) {
    event.preventDefault()
    console.log("drop")
    const drop = this.dropItemTarget.hidden
    console.log(drop)
    this.dropItemTarget.hidden = drop ? false : true
  }
}
