class Admin::OrganismsController < Admin::Base
  def destroy
    @organism = Organism.find(params[:id])
    @organism.destroy
    flash.notice = "削除しました。"
    redirect_to :admin_root
  end
end
