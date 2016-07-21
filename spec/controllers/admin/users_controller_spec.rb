require 'rails_helper'
require 'pry'

<<<<<<< b9194b89f41b39dbe3aa74df28069c5fe8d65753
RSpec.describe Admin::UsersController, type: :controller do
=======
RSpec.describe UsersController, type: :controller do
>>>>>>> team 7 refactored admin controllers and 1/6 tests
  let (:admin_user) { FactoryGirl.create(:admin) }
  let (:user) { FactoryGirl.create(:user) }
  let (:organization) { FactoryGirl.create(:organization) }
  describe "#new" do
<<<<<<< b9194b89f41b39dbe3aa74df28069c5fe8d65753
    context "as anon user" do
      it "redirects to root_path" do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end

    context "as an admin" do
      before { login(admin_user) }
      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end

      it "assigns the user instance variable" do
        get :new
        expect(assigns(:user)).to be_a_new(User)
      end
=======
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assigns the user instance variable" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
>>>>>>> team 7 refactored admin controllers and 1/6 tests
    end
  end

  describe "#create" do
<<<<<<< b9194b89f41b39dbe3aa74df28069c5fe8d65753
    context "as anon user" do
      it "redirects to root_path" do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to(root_path)
      end
    end
    context "with valid user attribute" do
      before { login(admin_user) }
=======
    context "with valid user attribute" do
>>>>>>> team 7 refactored admin controllers and 1/6 tests
      def valid_request
        post :create, user: FactoryGirl.attributes_for(:user)
      end

      it "creates a record in the database" do
          count_before = User.count
          valid_request
          count_after = User.count
          expect(count_after).to eq(count_before + 1)
      end

      # monkey-patched test mailer to call deliver_now
      # in spec/support/message_delivery.rb
      it "sends an account verification e-mail" do
        expect { valid_request }.to change{ActionMailer::Base.deliveries.count}.by(1)
      end

      it "renders the account verificaitons create page" do
        valid_request
        expect(response).to render_template("users/account_verifications/create")
      end

      it "sets the session user_id with the created user" do
        valid_request
        expect(session[:user_id]).to eq(User.last.id)
      end
    end

    context "with invalid user attribute" do
<<<<<<< b9194b89f41b39dbe3aa74df28069c5fe8d65753
      before { login(admin_user) }
=======
>>>>>>> team 7 refactored admin controllers and 1/6 tests
      def invalid_request
        post :create, user: FactoryGirl.attributes_for(:user).merge({first_name: nil})
      end

      it "doesn't add a record to the database" do
        count_before = User.count
        invalid_request
        count_after = User.count
        expect(count_after).to eq(count_before)
      end

      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end
    end

  end


  describe "#edit" do
    render_views
    describe "as a mortal" do
    before { login(user) }
<<<<<<< b9194b89f41b39dbe3aa74df28069c5fe8d65753
      it "redirects to root_path" do
        get :edit, id: user.id
        expect(response).to redirect_to(root_path)
=======
      it "doesn't show the option make the user an admin" do
        get :edit, id: user.id
        expect(response.body).not_to include("Admin")
>>>>>>> team 7 refactored admin controllers and 1/6 tests
      end
    end
    describe "as an admin" do
    before { login(admin_user) }
      it "shows the option to make the user an admin" do
        get :edit, id: user.id
        expect(response.body).to include("Admin")
      end
    end
  end

  describe "#update" do

    describe "as a mortal" do
<<<<<<< b9194b89f41b39dbe3aa74df28069c5fe8d65753
      before { login(user) }
      it "redirects to root_path" do
        get :edit, id: user.id
        expect(response).to redirect_to(root_path)
      end
    end
    describe "as administrators" do
      before { login(admin_user) }
=======
      before do
        login(user)
      end
      it "cannot update status to admin" do
        patch :update, id: user.id, user: {admin: true}
        expect(user.reload.admin).to eq(false)
      end
      it "cannot add organizations to users" do
        patch :update, id: user.id, user: {organization_id: organization.id}
        expect(user.reload.organization).not_to eq(organization)
      end
    end
    describe "as administrators" do
      before do
        login(admin_user)
      end
>>>>>>> team 7 refactored admin controllers and 1/6 tests
      it "can make more administrators" do
        patch :update, id: user.id, user: {admin: true}
        expect(user.reload.admin).to eq(true)
      end
      it "can add organizations to users" do
        patch :update, id: user.id, user: {organization_id: organization.id}
        expect(user.reload.organization).to eq(organization)
      end
    end
  end
end
