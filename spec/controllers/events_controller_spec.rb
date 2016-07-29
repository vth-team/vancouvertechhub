require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "crawls for new meet up events using task job" do
      Event.destroy_all
      count_before = Event.count
      DailyMeetupCrawlJob.perform_now
      count_after  = Event.count
      expect(count_after).not_to eq(count_before)
    end
  end
end
