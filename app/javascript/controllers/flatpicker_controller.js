import { Controller } from '@hotwired/stimulus'
import flatpickr from "flatpickr";

export default class extends Controller {
  static values = {
    dateFormat: String,
    yearDisabled: {
      type: Boolean,
      default: false
    }
  }

  connect() {
    flatpickr(this.element, {
      altInput: true,
      altFormat: !!this.dateFormatValue ? this.dateFormatValue : 'd/m/Y',
      enable: [
        (date) => {
          if (!this.yearDisabledValue) return true;
          return date.getFullYear() === new Date().getFullYear()
        }
      ]
    })
  }
}
