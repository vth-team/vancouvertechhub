require 'rails_helper'

RSpec.describe NewsController, type: :controller do
  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assigns an instance variable for all articles, ordered by published_date" do
      # given, there are at least two campaigns
      n1 = FactoryGirl.create(:news_article, published_on: Time.now - 3.days)
      n2 = FactoryGirl.create(:news_article, published_on: Time.now - 2.days )
      n3 = FactoryGirl.create(:news_article, published_on: Time.now - 1.days )
      # when, we call a get :index
      get :index

      # assigns would look for instance variable @articles
      # the array of articles, is ordered by the most recent publisehd_on time
      expect(assigns(:articles)).to eq([n3, n2, n1])
    end
  end
end
