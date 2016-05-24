require 'rails_helper'

RSpec.describe NewsArticle, type: :model do

  describe "validations" do
    it "requires a title" do
      n = NewsArticle.new

      validation_outcome = n.valid?

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
