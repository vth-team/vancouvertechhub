require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe "validations" do
    it "should have reasonable tech team size" do
      o = Organization.new FactoryGirl.attributes_for(:organization).merge({tech_team_size: 1000})
      expect(o).to be_invalid
    end

    it "should have a unique name" do
      o = FactoryGirl.create(:organization)
      o2 = Organization.new FactoryGirl.attributes_for(:organization).merge({name: o.name})
      expect(o2).to be_invalid
    end

    it "should have an address" do
      o = Organization.new FactoryGirl.attributes_for(:organization).merge({address: nil})
      expect(o).to be_invalid
    end

    it "should have an overview" do
      o = Organization.new FactoryGirl.attributes_for(:organization).merge({overview: nil})
      expect(o).to be_invalid
    end

    it "should have employees" do
      o = Organization.new FactoryGirl.attributes_for(:organization).merge({employee_count: 0})
      expect(o).to be_invalid
    end
  end
end
