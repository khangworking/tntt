class GcatholicService
  attr_reader :options, :agent, :page

  def initialize(url, options = {})
    @options = options
    @agent = Mechanize.new
    @page = init_page(url)
  end

  def tr_selector(month, day)
    formatted_month = "%0.2d" % month
    formatted_day = "%0.2d" % day
    "tr##{formatted_month}#{formatted_day}"
  end

  def init_page(url)
    agent.get(url)
  end

  def today
    year = Time.zone.now.year
    month = Time.zone.now.month
    day = Time.zone.now.day

    calc_day(day, month, year)
  end

  def calc_day(day, month, year)
    noko = page.search(tr_selector(month, day))[0].search('.indent')[0]
    return Array(noko.content.strip) if noko

    sibling_noko = []
    page.search("#{tr_selector(month, day)} ~ tr").each do |tr|
      break if tr['id'].present?

      if tr.search('a[class^="feast"]')[0]&.content&.strip&.in?(%w[n N T K])
        str = "feast:#{tr.search('.indent')[0].content.strip}"
        sibling_noko << str
      else
        sibling_noko << tr.search('.indent')[0]&.content&.strip
      end
    end
    Array(sibling_noko).compact
  end

  def range(start_date, end_date)
    (start_date..end_date).map do |date|
      events = calc_day(date.day, date.month, date.year)
      events.map do |evt|
        {
          title: evt.gsub('feast:', ''),
          start: I18n.l(date, format: :fullcalendar, locale: :en)
        }
      end
    end.flatten
  end
end
