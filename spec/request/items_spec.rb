require 'rails_helper'

describe "Items" do

  describe "Manage items" do

    let(:user) { FactoryGirl.create(:user) }

    it "Adds a new item and displays the results" do

      visit new_item_path(as: user)

      expect{
        fill_in "Name",        with: "Nike air"
        fill_in "Address",     with: "London, UK"
        fill_in "Tags",        with: "shoes"
        fill_in "Description", with: "37 eu"
        click_button "Create Item"
      }.to change(Item,:count).by(1)

      expect(page).to have_content "Nike air"
      expect(page).to have_content "London, UK"
      expect(page).to have_content "shoes"
      expect(page).to have_content "37 eu"
    end
  end

end