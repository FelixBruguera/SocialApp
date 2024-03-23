import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="editprofile"
export default class extends Controller {
  static targets = ['editButton', 'submit', 'cancel', 'cover', 'profile', 'location', 'currentLocation']
  edit() {
    this.submitTarget.className = 'button is-small is-link'
    this.cancelTarget.className = 'editing button is-small is-danger'
    this.coverTarget.className = 'editing'
    this.profileTarget.className = 'editing'
    this.locationTarget.className = 'editing'
    this.editButtonTarget.className = 'hidden'
    this.currentLocationTarget.id = 'hidden'
  }
  cancel() {
    this.submitTarget.className = 'hidden'
    this.cancelTarget.className = 'hidden'
    this.coverTarget.className = 'hidden'
    this.profileTarget.className = 'hidden'
    this.locationTarget.className = 'hidden'
    this.editButtonTarget.className = 'button is-small unfocused'
    this.currentLocationTarget.id = 'profile-location'
  }
}
