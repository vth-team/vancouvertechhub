class AddColumn < ActiveRecord::Migration
  def change
    add_column :events, :meetup_group, :string
  end
end
