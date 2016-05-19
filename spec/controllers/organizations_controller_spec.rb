require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
	let (:unpublished_attributes) do
	  FactoryGirl.attributes_for(:organization).merge({published: false})
	end

	let (:published_attributes) do
	 FactoryGirl.attributes_for(:organization).merge({published: true})
	end

	describe "#show" do
	 describe "as anon user" do
	   it "doesn't display unpublished organizations" do
	     org = Organization.new(unpublished_attributes)
	     org.save
	     begin
	       get :show, id: org.id
	     rescue
	       puts "not published"
	       puts org
	     end
	     expect(assigns(:organization)).not_to eq(org)
	   end

	   it "displays published organizations show page" do
	     org = Organization.new(published_attributes)
	     org.save
	     get :show, id: org.id
	     expect(assigns(:organization)).to eq(org)
	   end
	 end
		describe "as an admin" do
			it "display unpublished organizations" do
				org = Organization.new(unpublished_attributes)
				org.save
				user = User.new(FactoryGirl.attributes_for(:user).merge({admin: true}))
				user.save
				session[:user_id] = user.id
				get :show, id: org.id
				expect(assigns(:organization)).to eq(org)
			end
			it "display published organizations" do
			  org = Organization.new(published_attributes)
			  org.save
			  user = User.new(FactoryGirl.attributes_for(:user).merge({admin: true}))
			  user.save
			  session[:user_id] = user.id
			  get :show, id: org.id
			  expect(assigns(:organization)).to eq(org)
			end
		end
	end

	describe "#index" do
		describe "as anon user" do
			it "doesn't display unpublished organizations on index" do
				org = Organization.new(unpublished_attributes)
				org.save
				get :index
				expect(assigns(:organizations)).not_to include(org)
			end
			it "displays published organizations on index" do
				org = Organization.new(published_attributes)
				org.save
				get :index
				expect(assigns(:organizations)).to include(org)
			end
		end
		describe "as an admin" do
			it "does display unpublished organizations on index" do
				org = Organization.new(unpublished_attributes)
				org.save
				user = User.new(FactoryGirl.attributes_for(:user).merge({admin: true}))
				user.save
				session[:user_id] = user.id
				get :index
				expect(assigns(:organizations)).to include(org)
			end
			it "does display published organizations on index" do
				org = Organization.new(published_attributes)
				org.save
				user = User.new(FactoryGirl.attributes_for(:user).merge({admin: true}))
				user.save
				session[:user_id] = user.id
				get :index
				expect(assigns(:organizations)).to include(org)
			end
		end
	end
end
