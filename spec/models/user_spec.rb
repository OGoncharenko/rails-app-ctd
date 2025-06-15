require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(email: email, last_name: last_name, first_name: first_name, password: password) }
  let(:email) { 'test@test.com' }
  let(:last_name) { 'Doe' }
  let(:first_name) { 'John' }
  let(:password) { 'password123' }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    context "when email is missing" do
      let(:email) { nil }

      it "is not valid without an email" do
        expect(user).not_to be_valid
      end

      it "returns an error message for email" do
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end
    end

    context "when last name is missing" do
      let(:last_name) { nil }

      it "is not valid without a last name" do
        expect(user).not_to be_valid
      end

      it "returns an error message for last name" do
        user.valid?
        expect(user.errors[:last_name]).to include("can't be blank")
      end
    end

    context "when first name is missing" do
      let(:first_name) { nil }

      it "is not valid without a first name" do
        expect(user).not_to be_valid
      end

      it "returns an error message for first name" do
        user.valid?
        expect(user.errors[:first_name]).to include("can't be blank")
      end

    context "when password is missing" do
      let(:password) { nil }

      it "is not valid without a password" do
        expect(user).not_to be_valid
      end

      it "returns an error message for password" do
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end
    end
    end
  end

  describe "Associations" do
    let!(:list) { List.create(name: "Test List", user: user) }

    it "has many lists" do
      expect(user.lists).to include(list)
    end
  end
end
