require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validationts" do
    it "requires a first name" do
      u = User.new FactoryGirl.attributes_for(:user).merge({first_name: nil})
      expect(u).to be_invalid
    end

    it "requires a last name" do
      u = User.new FactoryGirl.attributes_for(:user).merge({last_name: nil})
      expect(u).to be_invalid
    end
    it "requires an email" do
      u = User.new FactoryGirl.attributes_for(:user).merge({email: nil})
      expect(u).to be_invalid
    end
    it "requires an unique email" do
      u = FactoryGirl.create(:user)
      u2 = User.new FactoryGirl.attributes_for(:user).merge({email: u.email})
      expect(u2).to be_invalid
    end

  end

  describe ".full_name" do
    it "returns concatenated first and last time titleize" do
      u = User.new FactoryGirl.attributes_for(:user).
        merge({first_name: "John", last_name: "Smith"})
      expect(u.full_name).to eq("John Smith")
    end

  end

  describe "hashing the password" do
    it "generates a password digest" do
      u = User.new FactoryGirl.attributes_for(:user)
      u.save
      expect(u.password_digest).to be
    end
  end

end
