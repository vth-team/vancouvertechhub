require 'rails_helper'

RSpec.describe ClaimRequestsController, type: :controller do
  let (:published_organization) {FactoryGirl.create(:published_organization)}

  describe "#new" do
    context "without a signed in user" do
      it "redirects to the login page" do
        get :new, organization_id: published_organization.id
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with a signed in user" do
      context "user without an organization" do
        let(:user) { FactoryGirl.create(:user) }
        before { login(user) }

        it "shows the organization claim request page" do
          get :new, organization_id: published_organization.id
          expect(response).to render_template(:new)
        end
      end

      context "user with an organization" do
        let(:user) { FactoryGirl.create(:user, organization: FactoryGirl.create(:published_organization)) }
        before { login(user) }

        it "redirects to the organization show page" do
          get :new, organization_id: published_organization.id
          expect(response).to redirect_to(organization_path(published_organization))
        end
      end
    end
  end
end
