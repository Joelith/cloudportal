FactoryGirl.define do
  factory :product do
    name "Example product"
	  factory :product_with_db do
	  	name "Standard Database"
	  	after(:create) do |product, evaluator|
	      create_list(:component_oracle_db, 1, product: product)
	    end
	  end
		factory :product_with_db_and_java do
	  	name "JavaAndDb"
	  	after(:create) do |product, evaluator|
	  		create(:component_oracle_db, product: product)
	  		create(:component_java, product: product)
	  	end	
	  end  
	end
end