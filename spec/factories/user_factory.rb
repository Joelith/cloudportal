FactoryGirl.define do
  factory :user do
    email 'example@example.com'
    password 'password'

    factory :admin do
        email 'admin@example.com'
        after(:create) {|user| user.add_role(:admin)}
    end

    factory :project_owner do
        email 'po@example.com'
        after(:create) {|user| user.add_role(:project_owner)}
    end

   end
end