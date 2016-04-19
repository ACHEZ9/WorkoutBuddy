class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include UsersHelper

  before_filter :require_login

  private

    def require_login
      unless logged_in?
        redirect_to root_path, notice: "Please Login to Continue"
      end
    end

    def render_404
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
    
end
