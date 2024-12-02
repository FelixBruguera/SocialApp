import { Controller } from "@hotwired/stimulus"
import consumer from "channels/consumer"

// Connects to data-controller="chat-select"
export default class extends Controller {
  static targets = ['chat']
  select() {
    this.chatTarget.classList.add('selected-chat')
    this.chatTarget.classList.remove('unseen')
    let subscriptions = consumer.subscriptions.subscriptions
    subscriptions.forEach(sub => consumer.subscriptions.remove(sub))
    this.subscribe()
    this.markAsRead()
  }

  subscribe() {
    let chatId = this.chatTarget.dataset.chatId
    consumer.subscriptions.create({channel: "ChatsChannel", room: chatId}, {
        connected() {
        },
        disconnected() {
            // Called when the subscription has been terminated by the server
        },
        received(data) {
          Turbo.renderStreamMessage(data)
        }
    }
  )}

  markAsRead() {
    let chatId = document.querySelector('.selected-chat').dataset.chatId
    const token = document.querySelector('meta[name="csrf-token"').content
    // https://socialapp-x98o.onrender.com/messages_read?chat_id=${chatId}&message=seen
    fetch(`http://127.0.0.1:3000/messages_read?chat_id=${chatId}`, {'method': 'POST',
      headers: {'Content-Type': 'application/json', 'X-CSRF-Token': token}})
  }  
}
