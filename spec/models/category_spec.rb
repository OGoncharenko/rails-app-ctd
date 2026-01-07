require 'rails_helper'

RSpec.describe Category, type: :model do
  it "is valid with valid attributes" do
    category = Category.new(name: "Test Category")
    expect(category).to be_valid
  end

  it "is not valid without a name" do
    category = Category.new(name: nil)
    expect(category).not_to be_valid
  end

  it "is not valid with a duplicate name" do
    Category.create(name: "Unique Category")
    duplicate_category = Category.new(name: "Unique Category")
    expect(duplicate_category).not_to be_valid
  end

  it "allows names that differ only by case" do
    Category.create!(name: "Category")
    category = Category.new(name: "category")
    expect(category).to be_valid
  end
end
