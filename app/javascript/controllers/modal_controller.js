import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['modalElement']

  show() {
    this.modalElementTarget.classList.remove('hidden')
    this.modalElementTarget.classList.add('fixed')
  }

  hide(e) {
    if (e.target !== this.modalElementTarget)
      return;
    this.modalElementTarget.classList.remove('fixed')
    this.modalElementTarget.classList.add('hidden')
  }
}
