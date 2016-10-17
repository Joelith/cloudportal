require "rails_helper"

RSpec.feature "Users can create new products" do
  #let(:user) { FactoryGirl.create(:user) }
  before do
  #  login_as(user)
  
		visit "/products"
    click_link "New Product"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Bronze Database"
    fill_in "Description", with: "Standard small configuration of the database"
    click_button "Create Product"

    expect(page).to have_content "Product has been created."
    expect(page).to have_content "Bronze Database"
 	end

end