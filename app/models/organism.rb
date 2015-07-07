# == Schema Information
#
# Table name: organisms
#
#  id                 :integer          not null, primary key
#  content_type       :string(255)
#  data               :binary(16777215)
#  description        :text(65535)
#  micromotion_degree :integer          default(10), not null
#  step_length        :integer          default(10), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require 'rmagick'
class Organism < ActiveRecord::Base
  attr_reader :uploaded_image
  attr_accessor :uploaded_image, :destroy_flag
  
  IMAGE_TYPES = { "image/jpeg" => "jpg", "image/gif" => "gif",
    "image/png" => "png" }
  
  validates :data, :content_type, presence: true
  validate :check_image
  
  def uploaded_image=(image)
    content_type = convert_content_type(image.content_type)
    image_title = image.original_filename
    extension  = File.extname(image_title)
    if content_type == "application/octet-stream"
      if extension.match(/.jpg/i)
        self.content_type = "image/jpeg"
      elsif extension.match(/.png/i)
        self.content_type = "image/png"
      elsif extension.match(/.gif/i)
        self.content_type = "image/gif"
      else
        self.content_type = convert_content_type(image.content_type)
      end
    else
      self.content_type = convert_content_type(image.content_type)
    end
    img = Magick::Image.from_blob(image.read).shift
    if img.columns == img.rows
      img = img.resize_to_fit(100, 100)
    elsif img.columns > img.rows
      img = img.resize_to_fit(100, 10000)
    else
      img = img.resize_to_fit(10000, 100)
    end
    self.data = img.to_blob
    @uploaded_image = image
  end
  
  def extension
    IMAGE_TYPES[content_type]
  end
  
  private
  def convert_content_type(ctype)
    ctype = ctype.rstrip.downcase
    case ctype
    when "image/pjpeg" then "image/jpeg"
    when "image/jpg" then "image/jpeg"
    when "image/x-png" then "image/png"
    else ctype
    end
  end

  def check_image
    if @uploaded_image
      if data.size > 5.megabytes
        errors.add(:uploaded_image, :too_big_image)
      end
      unless IMAGE_TYPES.has_key?(content_type)
        errors.add(:uploaded_image, :invalid_image)
      end
    end
  end
end
