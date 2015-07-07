FactoryGirl.define do
  factory :organism do
    uploaded_image Rack::Test::UploadedFile.new(Rails.root.join("spec/factories/files",
       "euglena.png"), "image/jpeg")
  end
end
