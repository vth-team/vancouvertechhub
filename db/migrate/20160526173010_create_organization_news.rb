class CreateOrganizationNews < ActiveRecord::Migration
  def change
    create_table :organization_news do |t|
      t.references :news_article, index: true, foreign_key: true
      t.references :organization, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
