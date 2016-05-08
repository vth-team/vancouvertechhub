class DailyMeetupCrawlJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    meetup_api = MeetupApi.new
    @events = meetup_api.method_request('self/calendar', {page: '50'})
      if @events[0]["venue"]
      url = @events[0]["event_url"]
      address = @events[0]["venue"]["name"] + ", " + @events[0]["venue"]["address_1"] + ", " + @events[0]["venue"]["city"]
      title = @events[0]["name"]
      time = Time.at(@events[0]["time"]/1000).strftime("%Y-%m-%d %I:%M:%S")
      event = Event.new
      event.meetup_title = title
      event.start_time = time
      event.meetup_url = url
      event.location = address
      event.save
    end

  end
end
