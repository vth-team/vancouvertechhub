class Organization < ActiveRecord::Base
  has_one :user, dependent: :nullify
  has_many :claim_requests, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :overview, presence: true
  validates :employee_count, presence: true, numericality: {greater_than_or_equal_to: 1}
  validates :tech_team_size, presence: true, numericality: {greater_than_or_equal_to: 1}
  validate :reasonable_tech_team_size

  has_many :organization_technologies, dependent: :destroy
  has_many :technologies, through: :organization_technologies
  has_many :organization_news, dependent: :destroy
  has_many :news_articles, through: :organization_news

  # # validates :twitter, uniqueness: true
  validates_inclusion_of :published, in: [true, false]

  geocoded_by :address
  after_validation :geocode

  # Company Avatar
  mount_uploader :image, ImageUploader
  # Company Pictures
  mount_uploader :image2, ImageUploader
  mount_uploader :image3, ImageUploader
  mount_uploader :image4, ImageUploader


  def self.unclaimed
    joins("left join users on users.organization_id = organizations.id").where("users.id": nil)
  end

  def user_full_name
    user ? user.full_name : ''
  end

  def self.published
    where(published: true)
  end

  def self.search(params)
    if params[:tech_team_size] || params[:technologies] || params[:name]
      @organizations = Organization.where('name ILIKE ?', "%#{params[:name]}").where('tech_team_size LIKE ?', "%#{params[:tech_team_size]}").where('technologies', "%#{params[:technologies]}")
    else
      all
    end
  end

  def reasonable_tech_team_size
    unless tech_team_size < employee_count
      errors.add(:tech_team_size, "Team size must be less than organization size")
    end
  end
end
