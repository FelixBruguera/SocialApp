import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = ['notis', 'notis-count']
  read() {
    this.notisTarget.className = 'noti-seen'
    this.notisCountTarget.textContent = ''
  }
}
