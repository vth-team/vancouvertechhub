class EventsController < ApplicationController

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to admin_events_path, flash: "Event Added"
    else
      redirect_to admin_events_path, alert: "Event Not Added"
    end
  end

  def index
    @events = Event.order(:start_time)
  end

  def destroy
    @event = Event.find params[:id]
    if @event.destroy
      redirect_to admin_events_path, flash: "Event Removed"
    else
      redirect_to admin_events_path, alert: "Event Not Removed"
    end
  end

  private

  def event_params
    params.require(:event).permit([:meetup_title, :meetup_url, :location])
  end

end
