class Technology < ActiveRecord::Base
  has_many :organization_technologies, dependent: :destroy
  has_many :organizations, through: :organization_technologies

  validates :name, presence: true, uniqueness: true
end
