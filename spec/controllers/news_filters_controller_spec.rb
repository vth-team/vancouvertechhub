require 'rails_helper'

RSpec.describe NewsFiltersController, type: :controller do

  describe "#create" do
    context "with valid attributes" do #i,e news_filter_params has the "right" params
      def valid_request
        post :create, news_filter: FactoryGirl.attributes_for(:news_filter)
      end
      it "adds @news_filter to the database" do
        count_before=NewsFilter.count
        valid_request
        count_after=NewsFilter.count
        expect(count_after).to eq(count_before +1)
      end
      it "redirects to admin_news_filters_path" do
        valid_request
        expect(response).to redirect_to(admin_news_filters_path)
      end
      it "gives a notice" do
        valid_request
        expect(flash[:notice]).to be
      end
    end
    context "with invalid attributes" do
      it "does not add  @news_filter to the database" do
      end
      it "redirects to admin_news_filters_path" do
      end
      it "gives a alert" do
      end
    end
  end

  describe "#destroy" do
    let(:news_filter) { FactoryGirl.create(:news_filter) }
    it "removes the newsfilter from the database " do
      news_filter
      count_before=NewsFilter.count
      delete :destroy, id: news_filter.id
      count_after= NewsFilter.count
      expect(count_after).to eq(count_before-1)
    end
  end
end
