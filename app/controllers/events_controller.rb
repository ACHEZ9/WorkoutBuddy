class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :attend, :unattend]

  helper_method :sort_column, :sort_direction
  # GET /events
  # GET /events.json
  def index
    @distance_default = ""
    @sport_default = ""
    if !params[:distance].blank? && params[:distance].to_i > 0
      @events = Event.near("Boston, MA", params[:distance].to_i)
      @distance_default = params[:distance]
    else
      @events = Event.all
    end

    if !params[:sport_id].blank?
      @events = @events.where(sport_id: params[:sport_id])
      @sport_default = params[:sport_id]
    end

    if sort_column == 'sports.name'
      @events = @events.includes(:sport)
    end

    @events = @events.order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])

   respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    # @event = current_user.events.build(event_params)
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        if logged_in?
          current_user.attend_event(@event)
        end
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # def attend
  #   @event.users << current_user
  #   @event.save
  # end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #PUT /events/1/attend
  def attend
    current_user.attend_event(@event)
    redirect_to @event, notice: 'You joined this event!'
  end

  def unattend
    current_user.unattend_event(@event)
    redirect_to current_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:desc, :time, :date, :location, :sport_id)
    end

   def sort_column
      Event.column_names.include?(params[:sort]) || params[:sort] == 'sports.name' ? params[:sort] : "date"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
