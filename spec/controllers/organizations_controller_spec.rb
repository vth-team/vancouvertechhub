require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
	let (:unpublished_organization) do
	  Organization.create(FactoryGirl.attributes_for(:organization).merge({published: false}))
	end

	let (:published_organization) do
	  Organization.create(FactoryGirl.attributes_for(:organization).merge({published: true}))
	end

	let (:admin_user) { User.create(FactoryGirl.attributes_for(:user).merge({admin: true})) }

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
			it "display unpublished organizations" do
				session[:user_id] = admin_user.id
				get :show, id: unpublished_organization.id
				expect(assigns(:organization)).to eq(unpublished_organization)
			end
			it "display published organizations" do
			  session[:user_id] = admin_user.id
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
			it "does display unpublished organizations on index" do
				session[:user_id] = admin_user.id
				get :index
				expect(assigns(:organizations)).to include(unpublished_organization)
			end
			it "does display published organizations on index" do
				session[:user_id] = admin_user.id
				get :index
				expect(assigns(:organizations)).to include(published_organization)
			end
		end
	end
end
