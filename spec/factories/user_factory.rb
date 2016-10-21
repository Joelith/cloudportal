FactoryGirl.define do
  factory :user do
    email 'example@example.com'
    password 'password'

    factory :admin do
        after(:create) {|user| user.add_role(:admin)}
    end

    factory :project_owner do
        after(:create) {|user| user.add_role(:project_owner)}
    end

   end
end