require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe "GET /users/:id" do
    context "show the user profile" do
      let!(:user) do
        User.create!(
          first_name: "Test",
          last_name: "User",
          email: "test_user@example.com",
          password: "password"
        )
      end

      it "displays the user information" do
        get user_path(user)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Test")
        expect(response.body).to include("User")
        expect(response.body).to include("test_user@example.com")
      end
    end
  end
end
