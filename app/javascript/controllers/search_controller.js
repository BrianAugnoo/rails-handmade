import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "form", "chatList"]

  searchUser(){
    this.formTarget.requestSubmit();
    const query = this.inputTarget.value.trim();
    if (query.length > 0) {
      this.chatListTarget.hidden = true;
    } else {
       this.chatListTarget.hidden = false;
    }
  }
}
