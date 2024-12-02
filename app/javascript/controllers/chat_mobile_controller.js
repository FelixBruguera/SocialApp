import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat-mobile"
export default class extends Controller {
  static targets = ["chat", "chats"]
  hideChats() {
    this.chatTarget.style.width = "100%"
    setTimeout(this.chatsTarget.id = 'chats-mobile', 10000)
  }
}
