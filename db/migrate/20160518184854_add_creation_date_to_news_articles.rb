class AddCreationDateToNewsArticles < ActiveRecord::Migration
  def change
    add_column :news_articles, :published_on, :datetime
    add_index(:news_articles, :published_on)
  end
end
