class AddImage4ToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :image4, :string
  end
end
