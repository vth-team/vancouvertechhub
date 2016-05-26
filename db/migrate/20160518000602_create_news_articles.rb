class CreateNewsArticles < ActiveRecord::Migration
  def change
    create_table :news_articles do |t|
      t.string :title
      t.text :snippet
      t.string :link
      t.string :thumbnail

      t.timestamps null: false
    end
  end
end
