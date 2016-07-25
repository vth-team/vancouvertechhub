require 'rails_helper'

# TODO You should also use FactoryGirl.create rather than User.create with FactoryGirl.attributes_for

RSpec.describe Admin::OrganizationsController, type: :controller do
  let (:unpublished_organization) {FactoryGirl.create(:organization)}
  let (:published_organization) {FactoryGirl.create(:published_organization)}
  let (:admin_user) { FactoryGirl.create(:admin) }

  describe "#show" do
    describe "as anon user" do
      it "redirects to root_path when asks for unpublished" do
        get :show, id: unpublished_organization.id
        expect(response).to redirect_to(root_path)
      end

      it "redirects to root_path when asks for published" do
        get :show, id: published_organization.id
        expect(response).to redirect_to(root_path)
      end
    end

    describe "as an admin" do
      before {login(admin_user)}
      it "display unpublished organizations" do
        get :show, id: unpublished_organization.id
        expect(assigns(:organization)).to eq(unpublished_organization)
      end
      it "display published organizations" do
        get :show, id: published_organization.id
        expect(assigns(:organization)).to eq(published_organization)
      end
    end
  end

  describe "#index" do

    describe "as anon user" do
      before do
        unpublished_organization
        published_organization
      end
      it "redirects to root_path" do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end

    describe "as an admin" do
      before {login(admin_user)}
      it "does display unpublished organizations on index" do
        get :index
        expect(assigns(:organizations)).to include(unpublished_organization)
      end
      it "does display published organizations on index" do
        get :index
        expect(assigns(:organizations)).to include(published_organization)
      end
    end
  end

  let(:user) { FactoryGirl.create(:user) }


  describe "#new" do
    context "user attempts to create another company while having an existing company" do
      let(:organization) { FactoryGirl.create(:organization) }
      let(:user) { FactoryGirl.create(:user, organization: organization) }
      before { login(user) }

      it "redirects to root_path" do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "#create" do
    context "without a signed in user" do
      it "redirects to root_path" do
        post :create, organization: FactoryGirl.attributes_for(:organization)
        expect(response).to redirect_to(root_path)
      end
    end

    context "with signed in user" do
      before { login(user) }
      it "redirects to root_path" do
        post :create, organization: FactoryGirl.attributes_for(:organization)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
