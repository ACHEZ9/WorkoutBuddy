class StaticPagesController < ApplicationController

  def home
    render :layout => "layout_for_home_only"
  end

  def help
  end

  def about
  end

  def contact
  end
end
