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

  describe "POST /users/sign_up" do
    context "create a new user" do
      it "creates the user and redirects to the homepage" do
        post user_registration_path, params: { user: { email: "new@user.com", first_name: "New", last_name: "User", password: "password", password_confirmation: "password" } }
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include("Welcome! You have signed up successfully")
        expect(response.body).to include("My Lists")
      end

      it "fails to create a user with invalid data" do
        post user_registration_path, params: { user: { email: "invalid_email", first_name: "", last_name: "User", password: "pass", password_confirmation: "word" } }
        expect(response).to have_http_status(:unprocessable_content)
        expect(response.body).to include("Email is invalid")
        expect(response.body).to include("Password is too short")
        expect(response.body).to include("Password confirmation doesn't match Password")
        expect(response.body).to include("First name can't be blank")
      end
    end
  end

  describe "POST /users/sign_in" do
    context "sign in an existing user" do
      let!(:user) do
        User.create!(
          first_name: "Existing",
          last_name: "User",
          email: "example@user.com",
          password: "password"
        )
      end
      it "signs in the user and redirects to the homepage" do
        post user_session_path, params: { user: { email: "example@user.com", password: "password" } }
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include("Signed in successfully")
        expect(response.body).to include("All Lists")
      end
      it "fails to sign in with incorrect credentials" do
        post user_session_path, params: { user: { email: "exampl@user.com", password: "wrongpassword" } }
        expect(response).to have_http_status(:unprocessable_content)
        expect(response.body).to include("Invalid Email or password")
      end
    end
  end
end
