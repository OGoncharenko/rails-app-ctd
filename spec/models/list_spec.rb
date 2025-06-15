require 'rails_helper'

RSpec.describe List, type: :model do
  let(:user) { User.create(email: 'test@test.com', last_name: 'Test', first_name: 'User', password: 'password123') }
  let(:category) { Category.create(name: 'Test Category') }
  let(:list) { List.create(name: name, user: user, categories: [ category ]) }

  let(:name) { 'Test List' }
  let!(:list_items) do
    [
      ListItem.create(name: 'Item 1', list: list, position: 1),
      ListItem.create(name: 'Item 2', list: list, position: 2)
    ]
  end

  describe "Associations" do
    it "belongs to a user" do
      expect(list.user).to eq(user)
    end

    it "belongs to a category" do
      expect(list.categories).to eq([ category ])
    end

    it "has many list items" do
      expect(list.list_items).to match_array(list_items)
    end
  end
end
