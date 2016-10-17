FactoryGirl.define do
  factory :product do
    name "Example product"
	  factory :product_with_db do
	  	name "Standard Database"

	  	after(:create) do |product, evaluator|
	      create_list(:oracle_db, 1, product: product)
	    end
	  end
	end
end