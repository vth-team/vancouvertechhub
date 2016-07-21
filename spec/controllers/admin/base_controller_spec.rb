require 'rails_helper'

RSpec.describe Admin::BaseController, type: :controller do

    context "signed-in non-admin users" do
      let(:user) { FactoryGirl.create(:user) }
      it "redirects to home page" do
        login(user)
        # get controller: :admin, action: :organizations
        # get :organizations
        expect(response).to redirect_to(root_path)
      end
    end

    context "signed-in admin users" do
      let(:admin) { FactoryGirl.create(:admin) }
      it "redirects to admin organizations page" do
        login(admin)
        get :organizations
        expect(response).to render_template(:organizations)
      end
    end

end
