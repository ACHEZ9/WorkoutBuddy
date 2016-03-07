class ActivitiesController < ApplicationController

  def new
    @activity = Activity.new
  end

  def create
    @activity = current_user.events.build(activity_params)
    if @activity.save
      flash[:notice] = 'User joined event!'
      redirect_to events_path
    else
      flash.now[:warning] = 'There were problems when trying to add the users'
      render :action => :new
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
