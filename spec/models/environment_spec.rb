require 'rails_helper'

RSpec.describe Environment, type: :model do
  it 'is valid with valid attributes' do
		expect(Environment.new(name:'Test', start_date: Time.now, end_date: 30.days.from_now, product: Product.new)).to be_valid
	end 
	it 'always has a start date before the end date' do
		expect(Environment.new(name: 'Test', start_date: Time.now, end_date: 30.days.ago, product: Product.new)).to_not be_valid
	end

	describe "config" do
  	it 'should replace wildcards' do
	  	instance = FactoryGirl.create(:component_oracle_db)
	  	e = Environment.new(name: 'Test')
	  	e.project = FactoryGirl.create(:project)
	  	clean = e.send(:clean_config, instance.config)
	  	expect(clean["service_name"]).to eq "Exam-Test-DB"
	  end

  	it "should replace wildcards with nested attributes" do
	  	instance = FactoryGirl.create(:component_ec2)
	  	e = Environment.new(name: 'Test')
	  	e.project = FactoryGirl.create(:project)
	  	clean = e.send(:clean_config, instance.config)
	  	expect(clean["tags"]["name"]).to eq "Exam-Test-EC2"
	  end
	end

	describe '.total_expenditure' do
		let!(:environment) {FactoryGirl.create(:environment_with_db)}

		it 'has no cost when just started' do
			expect(environment.total_expenditure).to eq 0
		end
		it 'has a cost after a few days' do
			time_travel_to(30.days.from_now)
			expect(environment.total_expenditure).to be > 0
			back_to_the_present
		end
		it "has no cost if it hasn't started yet" do
			environment.start_date = 5.days.from_now
			expect(environment.total_expenditure).to eq 0
			time_travel_to(2.days.from_now)
			expect(environment.total_expenditure).to eq 0
			back_to_the_present
		end
		it "should stop calculating once the end date is reached" do
			time_travel_to(90.days.from_now)
			total = environment.total_expenditure
			time_travel_to(100.days.from_now)
			expect(environment.total_expenditure).to eq total
			back_to_the_present
		end
	end
end
