require 'rails_helper'

RSpec.describe Project, type: :model do

	it 'is valid with valid attributes' do
		expect(Project.new(name:'Test', budget: 1000)).to be_valid
	end
	it 'is not valid without a name' do
		expect(Project.new).to_not be_valid
	end
	it 'is not valid without a budget' do
		expect(Project.new(name: 'Test')).to_not be_valid
	end
	it 'is not valid without a numerical budget' do
		expect(Project.new(name: 'Test', budget: 'abc')).to_not be_valid
	end

	describe "Associations" do
		it { should have_many(:environments) }
	end

	describe ".spend_against_budget" do
		let!(:project) { FactoryGirl.create(:project_with_db_instance) }

		it "should start at 0" do
			expect(project.spend_against_budget).to eq 0
		end
		it 'should increase over 30 days' do
			time_travel_to(30.days.from_now)
			expect(project.spend_against_budget).to be > 0
			back_to_the_present
		end
	end
end
