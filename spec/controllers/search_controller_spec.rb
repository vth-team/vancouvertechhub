require 'rails_helper'

RSpec.describe SearchController, type: :controller do

  describe '#search' do
    
    context "filter search results based on search queries" do

      
      
      it "returns the correct results for a 1 query search"
      it "returns the correct results for a 2 query search"
      it "returns the correct results for a 3 query search"
    end

    context "do not filter search results when the ajax request sends no queries" do
      it "returns all organizations for a request with no queries"
    end
    
  end
  
end
