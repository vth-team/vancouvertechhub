class Organization < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :address, presence: true
  validates :overview, presence: true
  validates :employee_count, presence: true, numericality: {greater_than_or_equal_to: 1}
  validates :tech_team_size, presence: true, numericality: {greater_than_or_equal_to: 1}

  has_many :organization_technologies, dependent: :destroy
  has_many :technologies, through: :organization_technologies

  # # validates :twitter, uniqueness: true
  validates_inclusion_of :published, :in => [true, false]

  geocoded_by :address
  after_validation :geocode

  def user_full_name
    user ? user.full_name : ""
  end

  private


end
