require 'rails_helper'

RSpec.describe Admin::TechnologiesController, type: :controller do
  let(:technology) { FactoryGirl.create(:technology) }
  let (:admin_user) { FactoryGirl.create(:admin) }
  describe "#create" do
    context "as anon user" do
      it "redirects you to root_path" do
        post :create, technology: FactoryGirl.attributes_for(:technology)
        expect(response).to redirect_to(root_path)
      end
    end

    context "as an admin" do
      before {login(admin_user)}
      it "creates a new technology" do
        count_before = Technology.count
        post :create, technology: FactoryGirl.attributes_for(:technology)
        count_after = Technology.count
        expect(count_after).to eq(count_before + 1)
      end

      it "redirects to admin_technologies_path" do
        post :create, technology: FactoryGirl.attributes_for(:technology)
        expect(response).to redirect_to(admin_technologies_path)
      end
    end
  end

  describe "#destroy" do
    let!(:technology) { FactoryGirl.create(:technology) }
    context "as anon user" do
      it "redirects to root_path" do
        delete :destroy, id: technology.id
        expect(response).to redirect_to(root_path)
      end
    end

    context "as an admin" do
      before {login(admin_user)}
      it "destroy that technology" do
        count_before = Technology.count
        delete :destroy, id: technology.id
        count_after = Technology.count
        expect(count_before).to eq(count_after + 1)
      end
      it "redirects to admin_technologies_path" do
        delete :destroy, id: technology.id
        expect(response).to redirect_to(admin_technologies_path)
      end
    end
  end

end
