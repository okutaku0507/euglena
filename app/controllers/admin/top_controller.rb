class Admin::TopController < Admin::Base
  skip_before_action :authorize_admin, only: [ :index ]
  def index
    redirect_to :new_admin_session unless current_admin
    @organisms = Organism.order('id desc')
  end
end
