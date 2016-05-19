require 'rails_helper'

# TODO You should also use FactoryGirl.create rather than User.create with FactoryGirl.attributes_for

RSpec.describe OrganizationsController, type: :controller do
  let (:unpublished_organization) {FactoryGirl.create(:organization)}
  let (:published_organization) {FactoryGirl.create(:published_organization)}
  let (:admin_user) { FactoryGirl.create(:admin) }

  describe "#show" do
    describe "as anon user" do
      it "doesn't display unpublished organizations" do
        expect {get :show, id: unpublished_organization.id}.to raise_exception(ActiveRecord::RecordNotFound)
      end

      it "displays published organizations show page" do
        get :show, id: published_organization.id
        expect(assigns(:organization)).to eq(published_organization)
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
      it "doesn't display unpublished organizations on index" do
        get :index
        expect(assigns(:organizations)).not_to include(unpublished_organization)
      end
      it "displays published organizations on index" do
        get :index
        expect(assigns(:organizations)).to include(published_organization)
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
end
