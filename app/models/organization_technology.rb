class OrganizationTechnology < ActiveRecord::Base
  belongs_to :technology
  belongs_to :organization

  validates :technology_id, uniqueness: {scope: :organization_id}

end
