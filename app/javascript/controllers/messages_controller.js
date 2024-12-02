import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="messages"
export default class extends Controller {
  static targets = ["messages", "form"]
  connect() {
      // this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight+250
      // setTimeout(this.messagesTarget.scrollBy(1, 1000000), 100)
  }

  markAsRead() {
    let chatId = document.querySelector('.selected-chat').dataset.chatId
    const token = document.querySelector('meta[name="csrf-token"').content
    // https://socialapp-x98o.onrender.com/messages_read?chat_id=${chatId}&message=seen
    fetch(`http://127.0.0.1:3000/messages_read?chat_id=${chatId}`, {'method': 'POST',
      headers: {'Content-Type': 'application/json', 'X-CSRF-Token': token}})
  }

  scroll() {
    // console.log(this.messagesTarget)
    // this.messagesTarget.scrollTop = this.formTarget.position.top
    // console.log(this.messagesTarget.scrollTop)
    // this.messagesTarget.scrollBy(1, 1000000000)
  }

}
