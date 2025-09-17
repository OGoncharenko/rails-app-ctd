require 'rails_helper'

RSpec.describe ListsController, type: :request do
  describe "GET /lists" do
    context "when lists exist" do
      before do
        user = User.create!(
          first_name: "Test",
          last_name: "User",
          email: "test_user@example.com",
          password: "password"
        )

        List.create!(name: "List 1", user: user)
        List.create!(name: "List 2", user: user)
      end

      it "returns a successful response" do
        get lists_path
        expect(response).to have_http_status(:ok)
      end

      it "displays the lists" do
        get lists_path

        expect(response.body).to include("List 1")
        expect(response.body).to include("List 2")
      end
    end
  end

  describe "GET /lists/:id" do
    context "show the list information" do
      let!(:user) do
        User.create!(
          first_name: "Test",
          last_name: "User",
          email: "test_user@example.com",
          password: "password"
        )
      end
      before do
        @list = List.create!(name: "List 1", user: user)
        categories = Category.create!([
                                        { name: "Category 1" },
                                        { name: "Category 2" }
                                      ])

        categories.each do |category|
          ListCategory.create!(category: category, list: @list)
        end
        ListItem.create!(name: "Item 1", position: 1, list: @list)
        ListItem.create!(name: "Item 2", position: 2, list: @list)
      end

      it "displays items of the list" do
        get list_path(@list)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Item 1")
        expect(response.body).to include("Item 2")
      end

      it "displays categories of the list" do
        get list_path(@list)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Category 1")
        expect(response.body).to include("Category 2")
      end
    end
  end
end
