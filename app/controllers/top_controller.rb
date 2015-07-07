class TopController < ApplicationController
  def index
  end
  
  def growth
    @organisms = [ Organism.where(name: 'euglena').first ] #Organism.order('id desc')
  end
end