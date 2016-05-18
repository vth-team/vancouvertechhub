require 'rails_helper'

RSpec.describe NewsFilter, type: :model do
  
  describe "validations" do
    it "requires a unique searchterm" do
      #a=NewsFilter.new(FactorGirl.attributes_for(:news_filter))
      a=NewsFilter.new(search_term: "a")
      a.save
      b=NewsFilter.new(search_term: "a")
      b.save
      expect(b).to be_invalid
    end


  end

end
