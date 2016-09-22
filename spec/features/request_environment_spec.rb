require "rails_helper"

RSpec.feature "Users can create environment" do
  #let(:user) { FactoryGirl.create(:user) }
  before do
  #  login_as(user)
  
		visit "/"
    click_link "Request Environment"
  end

  scenario "with valid attributes" do
    #fill_in "Name", with: "Bronze Database"
    #fill_in "Description", with: "Standard small configuration of the database"
    #click_button "Create Product"

    #expect(page).to have_content "Product has been created."
 	end
end