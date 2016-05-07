class EventsController < ApplicationController

  def index
    params = { category: '1',
      city: 'Vancouver',
      country: 'ca',
      status: 'upcoming',
      format: 'json',
      page: '5'}
    meetup_api = MeetupApi.new
    @events = meetup_api.open_events(params)

    @events["results"].each do |list|
      if list["venue"]
      url = list["link"]
      address = list["venue"]["name"] + ", " + list["venue"]["address_1"] + ", " + list["venue"]["city"]
      title = list["name"]
      byebug
      time = Time.at(list["time"]/1000).strftime("%a %I:%M%P %m/%d/%Y")
      puts "#{time}"
      event = Event.new
      # event.meetup_title = title
      # event.time = time
      # event.meetup_url = url
      # event.location = address
      # event.save
      end
    end
    render "/home/events"
  end

end
