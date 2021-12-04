import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["today"]

  connect() {
    this.fetchToday()
  }

  fetchToday() {
    if (!this.todayTarget) return;

    fetch('//calapi.inadiutorium.cz/api/v0/en/calendars/general-en/today')
      .then(res => res.json())
      .then(result => {
        this.todayTarget.innerHTML = result.celebrations.map(item => `${item.title}`).join('<br />')
      })
  }
}
