require 'rails_helper'

describe "Users" do

  describe "Manage users" do

    it "Adds a new user and displays the results" do

      visit sign_up_path

      expect{
        fill_in "Name",     with: "John Doe"
        fill_in "Email",    with: "doe@example.com"
        fill_in "Password", with: "foobar"
        click_button "Sign up"
      }.to change(User,:count).by(1)

      expect(page).to have_content "John Doe"
      expect(page).to have_content "doe@example.com"
    end
  end

end