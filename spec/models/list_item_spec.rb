require "rails_helper"

RSpec.describe ListItem, type: :model do
  let(:user) { User.create(email: 'test@test.com', last_name: 'Test', first_name: 'User', password: 'password123') }
  let(:list) { List.create(name: 'Test List', user: user) }

  describe "Associations" do
    it "belongs to a list" do
      list_item_one = ListItem.new(name: "Test Item", list: list, position: 1)
      list_item_two = ListItem.new(name: "Second Item", list: list, position: 2)
      expect(list_item_one.list).to eq(list)
      expect(list_item_two.list).to eq(list)
    end
  end
end
