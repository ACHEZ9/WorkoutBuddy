class ActivitiesController < ApplicationController

  def new
    @activity = Activity.new
  end

  def create
    # @activity = current_user.events.build(activity_params)
    @activity = Activity.new(activity_params)

    if @activity.save
      flash[:notice] = 'User joined event!'
      redirect_to events_path
    else
      flash.now[:warning] = 'There were problems when trying to add the users'
      render :action => :new
    end
  end

  def index
    @activity = Activity.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activity }
    end
  end

  private
 # Use callbacks to share common setup or constraints between actions.
 def set_acitivity
   @activity = Activity.find(params[:id])
 end

 def activity_params
  params.require(:activity).permit(:user_id, :event_id)
 end
end
