require 'rails_helper'

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

end
