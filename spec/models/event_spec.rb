require 'rails_helper'

RSpec.describe Event, type: :model do

  describe "validations" do
    it "requires an unique meetup_url" do
      e = Event.create(meetup_url:"www.meetup.com")
      e2 = Event.new(meetup_url:"www.meetup.com")
      expect(e2).to be_invalid
    end
  end

end
