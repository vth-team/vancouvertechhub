class OrganizationNews < ActiveRecord::Base
  belongs_to :news_article
  belongs_to :organization
end
