import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="friend-requests"
export default class extends Controller {
  static targets = ['button']
  change() {
    this.buttonTarget.classList.remove('unfocused')
    this.buttonTarget.classList.add('request-sent')
    this.buttonTarget.textContent = 'Request sent'
    this.buttonTarget.disabled = true
    console.log(this.buttonTarget)
  }
}
