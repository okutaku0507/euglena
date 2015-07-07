# == Schema Information
#
# Table name: organisms
#
#  id                   :integer          not null, primary key
#  content_type         :string(255)
#  data                 :binary(16777215)
#  description          :text(65535)
#  micromotion_degree   :integer          default(90), not null
#  step_length          :integer          default(50), not null
#  multiplication_speed :integer          default(5), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

FactoryGirl.define do
  factory :organism do
    uploaded_image Rack::Test::UploadedFile.new(Rails.root.join("spec/factories/files",
       "euglena.png"), "image/jpeg")
  end
end
