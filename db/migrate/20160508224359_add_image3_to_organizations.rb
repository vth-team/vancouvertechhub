class AddImage3ToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :image3, :string
  end
end
