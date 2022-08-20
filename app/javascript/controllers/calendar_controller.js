import { Controller } from '@hotwired/stimulus';
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from '@fullcalendar/list';

export default class extends Controller {
  connect() {
    let calendar = new Calendar(this.element, {
      plugins: [dayGridPlugin, listPlugin],
      initialView: 'dayGridMonth',
      height: '100%',
      events: 'http://localhost:3000/api/v0/gcatholics',
      eventDisplay: 'list-item',
      locale: 'vi',
      firstDay: 1
    })
    calendar.render()
  }
}
