require "rails_helper"

RSpec.feature "Users can create new projects" do
  #let(:user) { FactoryGirl.create(:user) }
  before do
  #  login_as(user)
  
		visit "/"
    click_link "Create Project"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Echelon"
    fill_in "Budget", with: "10000"
    click_button "Create Project"

    expect(page).to have_content "Project has been created."
    expect(page).to have_content "Echelon"
 	end

end