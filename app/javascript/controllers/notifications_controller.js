import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = ['notis', 'count', 'link', 'coloredButton']
  read() {
    for(const tgt of this.notisTargets) {tgt.className = 'noti-seen'}
    this.countTarget.textContent = ''
    this.countTarget.className = 'hidden'
    this.linkTarget.className = 'hidden'
  }
  readList() {
    for(const tgt of this.notisTargets) {tgt.className = 'noti-seen-list'}
  }
  openBar() {
    this.coloredButtonTarget.id = 'notifications-bell'
  }
}
