FactoryGirl.define do
  factory :environment do
    name "Dev"
    start_date Time.now
    end_date 90.days.from_now
    project
    association :product, factory: :product_with_db
  end
end