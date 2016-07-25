require 'rails_helper'

RSpec.describe Admin::TechnologiesController, type: :controller do
  let(:technology) { FactoryGirl.create(:technology) }

  describe "#create" do
    context "as anon user" do
      it "redirects you to root_path" do
        post :create, technology: FactoryGirl.attributes_for(:technology)
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
