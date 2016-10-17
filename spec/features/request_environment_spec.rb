require "rails_helper"

RSpec.feature "Users can create environment" do
  #let(:user) { FactoryGirl.create(:user) }
  before do
  #  login_as(user)
    project = FactoryGirl.create(:project, name: "Echelon", budget: 10000)
    product = FactoryGirl.create(:product, name: 'Bronze Database')
    FactoryGirl.create(:oracle_db, product: product)

    visit project_path(project)
    click_link "Request Environment"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Dev"
    select_date Time.now, :from => "Start date"
    select_date 90.days.from_now, :from => "End date"
    select "Bronze Database", :from=>"environment[product_id]"

    click_button "Create Environment"

    expect(page).to have_content "Environment has been requested."
    expect(page).to have_content "Eche_Dev_DB"
    expect(page).to have_content "PENDING"

 	end
end