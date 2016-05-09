class DailyMeetupCrawlJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    meetup_api = MeetupApi.new
    @meet = meetup_api.method_request('self/calendar', {})
    @meet.each do |list|
      if list["venue"]
      url = list["event_url"]
      address = list["venue"]["name"] + ", " + list["venue"]["address_1"] + ", " + list["venue"]["city"]
      title = list["name"]
      time = Time.at(list["time"]/1000).strftime("%Y-%m-%d %I:%M:%S")
      event = Event.new
      event.meetup_title = title
      event.start_time = time
      event.meetup_url = url
      event.location = address
      event.save
    end
  end

  end
end
