class Event < ActiveRecord::Base
  validates :meetup_url, uniqueness: true
end
