class ActivitiesController < ApplicationController
  def new
    @activity = Activity.new
  end

  def create
    @activity = current_user.events.build(event_registration_params)
    if @event_registration.save
      flash[:notice] = 'Activity created'
      redirect_to events_path
    else
      flash.now[:warning] = 'There were problems when trying to create a new activity'
      render :action => :new
    end
  end

  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activity_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_activity
    @activity = Activity.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:user_id, :event_id, :location, :time, :image)
  end
end
