class ChangeColumnAddDefaultToPublished < ActiveRecord::Migration
  def change
    change_column :organizations, :published, :boolean, :default => false
  end
end
