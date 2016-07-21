require 'rails_helper'

<<<<<<< b9194b89f41b39dbe3aa74df28069c5fe8d65753
class Admin::TestController < Admin::BaseController
  def test
    head :ok
  end
end

RSpec.describe Admin::TestController, type: :controller do
  let (:admin_user) { FactoryGirl.create(:admin) }
  let (:user) { FactoryGirl.create(:user) }
  before do
    login(user)
    Rails.application.routes.draw do
      root "organizations#index"
      get "/base/test" => "admin/test#test"
    end
  end

  after do
    Rails.application.reload_routes!
  end
  context "signed-in non-admin users" do
    it "redirects to home page" do
      get :test
      expect(response).to redirect_to(root_path)
    end
  end

  context "signed-in admin users" do
    before { login(admin_user) }
    it "gets OK status" do
      get :test
      expect(response.response_code).to eq(200)
    end
  end
=======
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
>>>>>>> team 7 refactored admin controllers and 1/6 tests

end
