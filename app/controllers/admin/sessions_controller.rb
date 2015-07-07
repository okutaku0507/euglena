class Admin::SessionsController < Admin::Base
  skip_before_action :authorize_admin
  
  def new
    if current_admin
      redirect_to :admin_root
    else
      @form = LoginForm.new
      render action: 'new'
    end
  end
  
  def create
    @form = LoginForm.new(params[:login_form])
    if @form.login.present?
      administrator = Administrator.find_by_login_name(@form.login)
    end
    if Admin::Authenticator.new(administrator).authenticate(@form.password)
      session[:administrator_id] = administrator.id
      flash.notice = "ログインしました。"
      redirect_to :admin_root
    else
      flash.now[:alert] = "ログインに失敗しました。"
      render action: 'new'
    end
  end
  
  def destroy
    session.delete(:administrator_id)
    flash.notice = "ログアウトしました。"
    redirect_to :admin_root
  end
end
