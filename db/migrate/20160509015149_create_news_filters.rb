class CreateNewsFilters < ActiveRecord::Migration
  def change
    create_table :news_filters do |t|
      t.string :search_term

      t.timestamps null: false
    end
  end
end
