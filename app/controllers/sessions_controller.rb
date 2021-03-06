class SessionsController < ApplicationController
  skip_before_filter :require_login

  def new
    if logged_in?
      redirect_to current_user
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      # flash.now[:danger] = 'Invalid email/password combination'
      redirect_to login_path, notice: 'Invalid email/password combination'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
