image = Rails.root.join("db/seeds/development", "euglena.png")
file = File.open(image, "rb")
uploaded_image = ActionDispatch::Http::UploadedFile.new(tempfile: file, filename: File.basename(file),
  type: "image/jpeg")
Organism.create({
  uploaded_image: uploaded_image
})