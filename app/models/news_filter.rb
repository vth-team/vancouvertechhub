class NewsFilter < ActiveRecord::Base
  validates :search_term, presence: true, uniqueness: true
end
