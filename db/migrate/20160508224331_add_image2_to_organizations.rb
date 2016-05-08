class AddImage2ToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :image2, :string
  end
end
