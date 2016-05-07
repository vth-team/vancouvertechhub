class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :meetup_title
      t.string :meetup_url
      t.string :location
      t.integer :time

      t.timestamps null: false
    end
  end
end
