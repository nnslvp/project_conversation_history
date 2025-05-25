import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["message"]

  connect() {
    setTimeout(() => {
      this.close()
    }, 5000)
  }

  close() {
    this.messageTarget.classList.add('hiding')
    setTimeout(() => {
      this.messageTarget.remove()
    }, 500)
  }
} 