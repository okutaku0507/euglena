class Admin::Base < ApplicationController
  before_action :authorize_admin
  layout "admin"

  private
  def authorize_admin
    unless current_admin
      redirect_to :root; return false
    end
  end
end
