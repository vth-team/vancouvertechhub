require 'rails_helper'

RSpec.describe NewsFiltersController, type: :controller do

  describe "#create" do
    context "with valid attributes" do
      def valid_request
        post :create, news_filter: FactoryGirl.attributes_for(:news_filter)
      end

      it "adds @news_filter to the database" do
        expect { valid_request }.to change{ NewsFilter.count }.by(1)
      end

      context "admin news filter behaviour" do
        before { valid_request }
        it { expect(response).to redirect_to(admin_news_filters_path) }
        it { expect(flash[:notice]).to be }
      end
    end

    context "with invalid attributes" do
      def invalid_request
        post :create, news_filter: { search_term: "" }
      end

      it "does not add @news_filter to the database", skip_before: true do
        expect { invalid_request }.to_not change{ NewsFilter.count }
      end

      context "admin news filter behaviour" do
        before { invalid_request }
        it { expect(response).to redirect_to(admin_news_filters_path) }
        it { expect(flash[:alert]).to be }
      end
    end
  end

  describe "#destroy" do
    let(:news_filter) { FactoryGirl.create(:news_filter) }

    it "removes the newsfilter from the database " do
      news_filter
      expect { delete :destroy, id: news_filter.id }.to change{ NewsFilter.count }.by(-1)
    end
  end
end
