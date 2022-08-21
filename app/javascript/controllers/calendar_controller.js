import { Controller } from '@hotwired/stimulus';
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from '@fullcalendar/list';

export default class extends Controller {
  static values = {
    initialView: {
      type: String,
      default: 'dayGridMonth'
    },
    hiddenDays: {
      type: Array,
      default: []
    },
    locale: {
      type: String,
      default: 'vi'
    },
    eventDisplay: {
      type: String,
      default: 'list-item'
    }
  }

  connect() {
    let calendar = new Calendar(this.element, {
      plugins: [dayGridPlugin, listPlugin],
      initialView: this.initialViewValue,
      height: '100%',
      hiddenDays: this.hiddenDaysValue,
      events: 'https://thieunhi.herokuapp.com/api/v0/gcatholics',
      eventDisplay: this.eventDisplayValue,
      locale: this.localeValue,
      firstDay: 1
    })
    calendar.render()
  }
}
