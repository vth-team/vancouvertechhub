class NewsArticle < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true

  has_many :organization_news, dependent: :destroy
  has_many :organizations, through: :organization_news

  def self.recent_news
    where("created_at > ?", DateTime.now - 1.month).order("published_on DESC")
  end
end
