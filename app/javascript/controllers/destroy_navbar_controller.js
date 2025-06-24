import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="destroy-navbar"
export default class extends Controller {
  connect() {
    console.log("destroy")
    document.querySelector("#nav-bar").remove()
  }
}
