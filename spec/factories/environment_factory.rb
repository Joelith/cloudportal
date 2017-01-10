FactoryGirl.define do
  factory :environment do
    name "Dev"
    start_date Time.now
    end_date 90.days.from_now
    project
    factory :environment_with_db do
      association :product, factory: :product_with_db
    end
    factory :environment_with_db_and_java do
      association :product, factory: :product_with_db_and_java
    end
  end
end