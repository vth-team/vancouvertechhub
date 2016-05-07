class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :address
      t.text :overview
      t.integer :employee_count
      t.integer :tech_team_size
      t.string :website
      t.string :twitter
      t.boolean :published

      t.timestamps null: false
    end
  end
end
