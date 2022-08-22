import { Controller } from '@hotwired/stimulus';
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from '@fullcalendar/list';

export default class extends Controller {
  static values = {
    initialView: { type: String, default: 'dayGridMonth' },
    hiddenDays: { type: Array, default: [] },
    locale: { type: String, default: 'vi' },
    eventDisplay: { type: String, default: 'auto' },
    events: { type: String, default: 'https://thieunhi.herokuapp.com/api/v0/events' },
    accessToken: { type: String, default: '' },
    editable: { type: Boolean, default: false }
  }

  connect() {
    let calendar = new Calendar(this.element, {
      plugins: [dayGridPlugin, listPlugin],
      initialView: this.initialViewValue,
      editable: this.editableValue,
      height: '100%',
      hiddenDays: this.hiddenDaysValue,
      eventSources: [
        {
          url: this.eventsValue
        }
      ],
      eventDisplay: this.eventDisplayValue,
      locale: this.localeValue,
      firstDay: 1,
      loading: isLoading => {
        if (!document.querySelector('.fc-prev-button') || !document.querySelector('.fc-next-button')) return;

        if (isLoading) {
          document.querySelector('.fc-prev-button').setAttribute('disabled', 'disabled')
          document.querySelector('.fc-next-button').setAttribute('disabled', 'disabled')
        } else {
          document.querySelector('.fc-prev-button').removeAttribute('disabled')
          document.querySelector('.fc-next-button').removeAttribute('disabled')
        }
      }
    })
    calendar.render()
  }
}
