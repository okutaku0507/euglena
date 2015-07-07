FactoryGirl.define do
  factory :administrator do 
    sequence(:login_name) { |n| "test#{n}" }
    hashed_password BCrypt::Password.create("password")
  end
end
