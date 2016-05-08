class AddGeocodingFieldsToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :longitude, :float
    add_column :organizations, :latitude, :float
  end
end
