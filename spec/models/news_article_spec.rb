require 'rails_helper'

RSpec.describe NewsArticle, type: :model do

  describe "validations" do
    it "requires a title" do
        # GIVEN: campgain with no title
        n = NewsArticle.new

        # WEHN: we validate the campaign
        validation_outcome = n.valid?

        # THEN: validation_outcome is false
        expect(validation_outcome).to eq(false)

    end

    it "requires a unique title" do

      NewsArticle.create title: "hello"
      n1 = NewsArticle.new title: "hello"

      n1.valid?

      expect(n1.errors).to have_key :title
    end
  end
  
end

####test for uniqsnes of title, and presence
