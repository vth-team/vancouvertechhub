module EventsHelper
  def formatted_time_zeropadded(time)
    # TODO: Fix Meetup API scraping
    # Time scraped from rake task is not being parsed correctly
    # UTC time is off by 5 hours, which disallows use of .localtime
    correctTime = time + 12.hours
    correctTime.strftime('%I:%M %p')
  end

  def formatted_time(time)
    correctTime = time + 12.hours
    correctTime.strftime('%l:%M %p')
  end

  def formatted_date(date)
    correctDate = date + 12.hours
    correctDate.strftime('%d %B %Y at %l:%M%p')
  end
end
