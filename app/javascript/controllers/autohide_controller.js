import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static values = {
    seconds: String
  }

  connect() {
    setTimeout(() => {
      this.element.remove()
    }, this.secondsValue)
  }
}
