require "rails_helper"

RSpec.feature "Users can create new components in product" do
  let(:user) { FactoryGirl.create(:admin) }
  before do
    login_as(user)
    product = FactoryGirl.create(:product, name: 'Bronze Database')

		visit product_path(product)
  end

  scenario " - Oracle Cloud Database" do
    click_link "Create Oracle Database Cloud Service"

    fill_in "Service name", with: "%PROJ_4%_%ENV_4%"
    select "SE", :from=>"cp_oraclecloud_database_component[edition]"
    select "Oc3", :from=>"cp_oraclecloud_database_component[shape]"
    select "PAAS", :from=>"cp_oraclecloud_database_component[level]"
    select "HOURLY", :from=>"cp_oraclecloud_database_component[subscription_type]"
    select "None", :from=>"cp_oraclecloud_database_component[backup_destination]"
    fill_in "Version", with: "12.1"
    fill_in "Ssh key", with: "ssh-rsa fsdfsdf"
    fill_in "Admin password", with: "welcome1"
    click_button "Save"

    expect(page).to have_content "Component has been added."
 	end

end