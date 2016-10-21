require "rails_helper"
require 'pp'
RSpec.feature "Users can view an instance" do
  include ActiveJob::TestHelper

  let(:user) { FactoryGirl.create(:project_owner) }
  let(:project) { FactoryGirl.create(:project) }

  before do
    FactoryGirl.create(:product_with_db, name: 'Platinum Database')
    login_as(user)
    visit project_path(project)
    click_link "Request Environment"
    fill_in "Name", with: "Dev"
    select_date Time.now, :from => "Start date"
    select_date 90.days.from_now, :from => "End date"
    select "Platinum Database", :from=>"environment[product_id]"  
  end

  scenario "see status and backup" do
    expect { click_button "Create Environment" }.to change { enqueued_jobs.size }.by(1)
    perform_enqueued_jobs { CloudProvisionerJob.perform_now(*enqueued_jobs.first[:args]) }
    visit project_environment_path(project, project.environments.first)

    expect(page).to have_content "PROVISIONED"
    click_link "#{project.environments.first.cloud_instances.first.name}"
    expect(page).to have_content "Status Running"
    click_link "Backup"
    expect(page).to have_content "Backup has been requested"
    y = Time.now.strftime('%Y')
    expect(page).to have_content "TAG#{y}"
 	end
end