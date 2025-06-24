import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "form", "chatList", "users", "arts"]

  searchUser(){
    this.formTarget.requestSubmit();
    const query = this.inputTarget.value.trim();
    if (query.length > 0) {
      this.chatListTarget.hidden = true;
    } else {
       this.chatListTarget.hidden = false;
    }
  }

  showUsers(event) {
    event.preventDefault();
    this.usersTarget.hidden = false;
    this.artsTarget.hidden = true;
  }

  showArts(event) {
    event.preventDefault();
    this.artsTarget.hidden = false;
    this.usersTarget.hidden = true;
  }
}
