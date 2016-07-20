class OrganizationNews < ActiveRecord::Base
  belongs_to :news_article
  belongs_to :organization

  validates :news_article_id, uniqueness: {scope: :organization_id}
end
