class TopController < ApplicationController
  def index
  end
  
  def growth
    @organisms = [ Organism.where(description: 'euglena').first ].compact #Organism.order('id desc')
  end
end