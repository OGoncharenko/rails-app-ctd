require "rails_helper"

RSpec.describe ListCategory, type: :model do
  let(:user) { User.create(email: 'test@test.com', last_name: 'Test', first_name: 'User', password: 'password123') }
  let(:category) { Category.create(name: 'Test Category') }
  let(:list) { List.create(name: 'Test List', user: user, categories: [category]) }
  let(:list_category) { ListCategory.create(list: list, category: category) }

  describe "Associations" do
    it "belongs to a list" do
      expect(list_category.list).to eq(list)
    end

    it "belongs to a category" do
      expect(list_category.category).to eq(category)
    end

    it "validates uniqueness of list and category combination" do
      duplicate_list_category = ListCategory.new(list: list, category: category)
      expect(duplicate_list_category).not_to be_valid
      expect(duplicate_list_category.errors[:category_id]).to include("has already been taken")
    end
  end
end
