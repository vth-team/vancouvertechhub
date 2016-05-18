require 'rails_helper'

RSpec.describe NewsController, type: :controller do

  describe "#index" do

      it "renders the index template" do
        get :index
        expect(response).to render_template(:index)

      end


  end

  describe "#string_search_terms" do


  end





end
