class ChangeColumn3 < ActiveRecord::Migration
  def change
    rename_column :events, :time, :start_time
  end
end
