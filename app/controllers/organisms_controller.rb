class OrganismsController < ApplicationController
  def show
    @organism = Organism.find(params[:id])
    send_image if params[:format].in?(["jpg", "png", "gif"])
  end

  private
  def send_image
    if @organism.data.present?
      data = @organism.data
      img = Magick::Image.from_blob(data).shift
      send_data img.to_blob,
        type: @organism.content_type, disposition: "inline"
    else
      raise NotFound
    end
  end
end
