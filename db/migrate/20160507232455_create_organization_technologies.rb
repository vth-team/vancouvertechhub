class CreateOrganizationTechnologies < ActiveRecord::Migration
  def change
    create_table :organization_technologies do |t|
      t.references :technology, index: true, foreign_key: true
      t.references :organization, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
