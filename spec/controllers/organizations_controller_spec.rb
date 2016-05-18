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

<<<<<<< 81e672fcd3f36f3feb25b88f0c47d134445b7f63
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
=======
  let(:user) { FactoryGirl.create(:user) }


  describe "#new" do
    context "user attempts to create another comapny while having an existing company" do
      let(:organization) { FactoryGirl.create(:organization) }
      let(:user) { FactoryGirl.create(:user, organization: organization) }
      before { request.session[:user_id] = user.id }

      # def invalid_request
      #   post :create, organization: FactoryGirl.attributes_for(:organization{})
      # end

      it "redirects to the user's organization show page" do
        get :new
        expect(response).to redirect_to(organization_path(user.organization_id))
      end

    end
  
  end




  describe "#create" do
    context "without a signed in user" do
      it "redirects to sign up page" do
        post :create, organization: FactoryGirl.attributes_for(:organization)
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with signed in user" do
      before { request.session[:user_id] = user.id }
      describe "with valid attributes" do
        def valid_request
          post :create, organization: FactoryGirl.attributes_for(:organization)
        end

        it "saves a record to the database" do
          count_before = Organization.count
          valid_request
          count_after = Organization.count
          expect(count_after).to eq(count_before + 1)
        end

        it "redirects to the organization's show page" do
          valid_request
          expect(response).to redirect_to(organization_path(Organization.last))
        end

        it "sets a flash message" do
          valid_request
          expect(flash[:notice]).to be
        end
      end


    end

  end

>>>>>>> Add rspec tests for creating organization
end
