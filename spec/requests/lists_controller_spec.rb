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

  describe "POST /lists" do
    let!(:user) do
        User.create!(
          first_name: "Test",
          last_name: "User",
          email: "test@user.com",
          password: "password"
        )
      end

      it "creates a new list" do
        get new_list_path
        expect(response).to have_http_status(:ok)

        post lists_path, params: { list: { name: "New List", description: "List Description", user_id: user.id } }
        follow_redirect!
        expect(response.body).to include("New List")
        expect(response.body).to include("Created by: #{user.first_name} #{user.last_name}")
      end
  end

  describe "PUT /lists" do
    let!(:user) do
      User.create!(
        first_name: "Test",
        last_name: "User",
        email: "test@user.com",
        password: "password"
      )
    end

    it "updates an existing list" do
      list = List.create!(name: "Old List", description: "Old Description", user: user)

      get edit_list_path(list)
      expect(response).to have_http_status(:ok)

      put list_path(list), params: { list: { name: "Updated List", description: "Updated Description" } }
      follow_redirect!
      expect(response.body).to include("Updated List")
    end
  end

  describe "DELETE /lists/:id" do
    let!(:user) do
      User.create!(
        first_name: "Test",
        last_name: "User",
        email: "test@user.com",
        password: "password"
      )
    end

    it "deletes an existing list" do
      list = List.create!(name: "List to Delete", description: "Description", user: user)

      delete list_path(list)
      follow_redirect!
      expect(response.body).not_to include("List to Delete")
    end
  end
end
