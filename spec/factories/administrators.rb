# == Schema Information
#
# Table name: administrators
#
#  id              :integer          not null, primary key
#  login_name      :string(255)      not null
#  hashed_password :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_administrators_on_login_name  (login_name)
#

FactoryGirl.define do
  factory :administrator do 
    sequence(:login_name) { |n| "test#{n}" }
    hashed_password BCrypt::Password.create("password")
  end
end
