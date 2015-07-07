# == Schema Information
#
# Table name: organisms
#
#  id                 :integer          not null, primary key
#  content_type       :string(255)
#  data               :binary(65535)
#  description        :text(65535)
#  micromotion_degree :integer          default(10), not null
#  step_length        :integer          default(10), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryGirl.define do
  factory :organism do
    uploaded_image Rack::Test::UploadedFile.new(Rails.root.join("spec/factories/files",
       "euglena.png"), "image/jpeg")
  end
end
