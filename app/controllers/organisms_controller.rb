class OrganismsController < ApplicationController
  def show
    @organism = Organism.find(params[:id])
    if params[:format].in?(["jpg", "png", "gif"])
      send_image
    end
  end
  
  def create
    if params[:uploaded_image].present?
      @organism = Organism.new
      @organism.uploaded_image = params[:uploaded_image]
      if @organism.save!
        host = request.host + (Rails.env.development? ? ":3000" : "")
        render json: [ @organism.id, @organism.extension,
          @organism.micromotion_degree, @organism.step_length, @organism.multiplication_speed ]
      else
        render json: [ 'error' ]
      end
    else
      render json: [ 'error' ]
    end
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
