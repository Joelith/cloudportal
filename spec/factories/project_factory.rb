FactoryGirl.define do
  factory :project do
    name "Example product"
    budget 10000
    factory :project_with_db_instance do
    	after(:create) do |project, evaluator|
	  		create(:environment_with_db, project: project)
	  	end
    end
  end
end