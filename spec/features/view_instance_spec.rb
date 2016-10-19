require "rails_helper"
require 'pp'
RSpec.feature "Users can view an instance" do
  #let(:user) { FactoryGirl.create(:user) }
  #let(:environment) { FactoryGirl.create(:environment_with_db_and_java) }
  before(:all) do
  #  login_as(user)
    @environment = FactoryGirl.create(:environment_with_db_and_java)
  end

  before do
    visit project_environment_path(@environment.project, @environment)
  end

  scenario "has status" do
    wait_for(@environment.cloud_instances.first.status).to eq("PROVISIONED")

    click_link "#{@environment.cloud_instances.first.name}"

    expect(page).to have_content "Status Running"
 	end

  scenario "can backup" do
    wait_for(@environment.cloud_instances.first.status).to eq("PROVISIONED")
    click_link "#{@environment.cloud_instances.first.name}"
    click_link "Backup"
    expect(page).to have_content "Backup has been requested"
    y = Time.now.strftime('%Y')
    expect(page).to have_content "TAG#{y}"
  end

  after(:all) do
    @environment.product.destroy
    @environment.project.destroy
  end
end