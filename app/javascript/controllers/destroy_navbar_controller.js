import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="destroy-navbar"
export default class extends Controller {
  connect() {
    console.log("destroy")
    const nav_bar = document.querySelector("#nav-bar")
    if (nav_bar !== null){
      nav_bar.remove()
    }
  }
}
