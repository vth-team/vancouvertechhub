class NewsArticle < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true

  def self.recent_news
    where("created_at > ?", DateTime.now - 1.month).order("published_on DESC")
  end
end
