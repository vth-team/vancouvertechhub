class Organization < ActiveRecord::Base
  # belongs_to user - todo
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :overview, presence: true
  validates :employee_count, presence: true, numericality: {greater_than_or_equal_to: 1}
  validates :tech_team_size, presence: true, numericality: {greater_than_or_equal_to: 1}
  validates :twitter, uniqueness: true
  validates :published, presence: true

end
