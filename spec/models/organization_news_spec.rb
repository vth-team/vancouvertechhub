require 'rails_helper'

RSpec.describe OrganizationNews, type: :model do
  let(:organization) { FactoryGirl.create(:organization) }
  let(:news_article) { FactoryGirl.create(:news_article) }

  describe "validations" do
    it "requires a unique combination of news article id and organizaiton id" do
      n = OrganizationNews.create(organization_id: organization.id, news_article_id: news_article.id)
      n.save
      n1 = OrganizationNews.create(organization_id: organization.id, news_article_id: news_article.id)

      expect(n1).to be_invalid
    end
  end
end
