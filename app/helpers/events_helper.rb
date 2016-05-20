module EventsHelper
  def formatted_time(time)
    # TODO: Fix Meetup API scraping
    # Time scraped from rake task is not being parsed correctly
    # UTC time is off by 5 hours, which disallows use of .localtime
    correctTime = time + 12.hours
    correctTime.strftime('%I:%M %p')
  end
end
