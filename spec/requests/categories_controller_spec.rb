require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "GET /categories" do
    context "categories exist" do
      before do
        (1..2).each do |i|
          Category.create!(
            name: "Category #{i}"
          )
        end
      end

      it "returns a list of categories" do
        get '/categories'

        expect(response.body).to include('Category 1')
        expect(response.body).to include('Category 2')
      end
    end
  end

  describe "GET /categories/:id" do
    context "show the category information" do
      before do
        @category = Category.create!(
          name: "Category 1"
        )
        @list = List.create!(
          name: "List 1",
          user: User.create!(
            first_name: "Test",
            last_name: "User",
            email: "test_user@example.com",
            password: "password"
          )
        )
        ListCategory.create!(category: @category, list: @list)
      end

      it "displays the category details" do
        get category_path(@category)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Category 1")
      end

      it "displays lists under the category" do
        get category_path(@category)
        expect(response.body).to include("List 1")
      end
    end
  end
end
