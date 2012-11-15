FactoryGirl.define do
  sequence(:email) {|n| "test-#{n}@test.com"}
  
  factory :user do
    email { generate(:email) }
    password "password"
    password_confirmation { password }
    phone_no "1234567890"
  end
end
