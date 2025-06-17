import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="session"
export default class extends Controller {
  static targets = ["body", "online", "offline"]
  connect() {
    console.log("Session controller connected");
    const online = this.bodyTarget.getAttribute("online")
    if (online === "false") {
      this.bodyTarget.setAttribute("online", "true")
      this.onlineTarget.click()
      console.log(this.onlineTarget);
    }

    window.addEventListener("beforeunload", () => {
      const data = new FormData(this.offlineTarget)
      this.offlineTarget.preventDefault()
      this.disconnect(data)
    })
  }

  disconnect(data) {
    fetch(this.offlineTarget.action, {
      method: "POST",
      body: data,
      keepalive: true,
    })
  }
}
