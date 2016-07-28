require 'rails_helper'

RSpec.describe SearchController, type: :controller do

  describe '#search' do
    
    context "filter search results based on search queries" do

      let (:tech2) { FactoryGirl.create(:technology, name: 'tech2')}
      let (:techs) { [FactoryGirl.create(:technology, name: 'tech1'), tech2]}
      let! (:organization_1) {FactoryGirl.create(:published_organization, name: "test organization", tech_team_size: 10, technologies: techs)}
      let (:techs2) { [FactoryGirl.create(:technology, name: 'tech3'), tech2] }
      let! (:organization_2) {FactoryGirl.create(:published_organization, name: "yyyo", tech_team_size: 40)}

      context "with a one query search" do
        it "returns the correct results for query term 'test', size '0' (default)" do
          get :search, { term: "test", size: "0", tech: "" }
          expect(response.body).to eq([organization_1].to_json)
        end

        it "returns the correct results for query size 1" do
          get :search, { term: "", size: "1", tech: "" }
          expect(response.body).to eq([organization_1].to_json)
        end

        it "returns the correct results for query size '0' (default), tech '1'"  do
          get :search, { term: "", size: "0", tech: "1" }
          expect(response.body).to eq([organization_1].to_json)
        end
        
        it "returns the correct results for query size '0' (default), tech '2'" do
          get :search, { term: "", size: "0", tech: "2" }          
          expect(response.body).to eq([organization_2].to_json)
        end
      end
      
    end
    
    #   it "returns the correct results for a 2 query search" do
    #     get :search, term: "test", size: "0", tech: "2"
    #     expect(assigns(@results)).to eq(organization_1)
    #     get :search, term: "y", size: "0", tech: "2"
    #     expect(assigns(@results)).to eq(organization_2)
    #   end
    
    #   it "returns the correct results for a 3 query search" do
    #     get :search, term: "o", size: "0", tech: "2"
    #     expect(assigns(@results)).to eq([organization_1, organization_2])
    #     get :search, term: "o", size: "2", tech: "3"
    #     expect(assigns(@results)).to eq(organization_2)
    #   end
    
    # end

    # context "do not filter search results when the ajax request sends no queries" do
    #   it "returns all organizations for a request with no queries"
    # end
    
  end
end
