class ChangeColumn2 < ActiveRecord::Migration
  def change
    remove_column :events, :time
    add_column :events, :time, :datetime
  end
end
