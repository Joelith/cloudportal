require "rails_helper"

RSpec.feature "Environments will expire" do
  include ActiveJob::TestHelper

  let(:env) { FactoryGirl.create(:environment_with_db) }
  let(:user) { FactoryGirl.create(:project_owner) }

  before do
    login_as(user)
    visit project_environment_path(env.project, env)
  end

  scenario "when near end_date" do
    time_travel_to(env.end_date - 29.days)
    visit project_environment_path(env.project, env)
    expect(page).to have_content "environment is set to expire soon"
    expect(page).to have_selector(:link_or_button, "Renew")
 	end

  scenario "but not when outside expiry time" do
    expect(page).to_not have_content "environment is set to expire soon"
    expect(page).to_not have_selector(:link_or_button, "Renew")
  end

  scenario "but not when expired" do
    time_travel_to(env.end_date + 10.days)
    visit project_environment_path(env.project, env)
    expect(page).to_not have_content "environment is set to expire soon"
    expect(page).to_not have_selector(:link_or_button, "Renew")
  end

  scenario "and can be renewed with date in the future" do
    time_travel_to(env.end_date - 29.days)
    visit project_environment_path(env.project, env)

    click_link "Renew"
    expect(page).to have_content "Justification"
    expect(page).to have_selector(:link_or_button, "Renew")

    select_date 90.days.from_now, :from => "End date"
    fill_in "Justification", with: "Need more time"

    click_button "Renew"

    expect(page).to have_content "Environment has been renewed."
    expect(page).to have_content 90.days.from_now.strftime("%Y-%m-%d")
  end

  scenario "and will have their instances deleted" do
    time_travel_to(env.end_date + 10.days)
    # Force the instances to be built
    perform_enqueued_jobs { CloudProvisionerJob.perform_now(*enqueued_jobs.first[:args]) }
    visit project_environment_path(env.project, env)
    expect(page).to have_content "PROVISIONED"

    # Force the cron job to run to deprovision them
    schedule = Whenever::Test::Schedule.new(file: 'config/schedule.rb')
    schedule.jobs[:runner].each{ |job| instance_eval job[:task] }

    visit project_environment_path(env.project, env)
    expect(page).to have_content "DEPROVISIONED"
    expect(page).to_not have_link('Exam-Dev-DB')
  end

  after(:each) do
    back_to_the_present
  end
end