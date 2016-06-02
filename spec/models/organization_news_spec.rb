require 'rails_helper'

RSpec.describe OrganizationNews, type: :model do

  describe "validations" do
    it "requires a unique combination of news article id and organization id" do
      n = FactoryGirl.create(:organization_news)
      n.save
      n1 = OrganizationNews.create(organization_id: n.organization_id, news_article_id: n.news_article_id)

      expect(n1).to be_invalid
    end
  end
end
