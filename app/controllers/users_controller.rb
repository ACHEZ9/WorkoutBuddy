class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_filter :require_login, only: [:new, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def recommendations
    @distance_default = ""
    @sport_default = ""
    if !params[:distance].blank? && params[:distance].to_i > 0
      puts request.location.coordinates
      @events = Event.near("Boston, MA", params[:distance].to_i).search(params[:search])
      @distance_default = params[:distance]
    else
      @events = Event.search(params[:search])
    end

    if !params[:sport_id].blank?
      @events = @events.where(sport_id: params[:sport_id])
      @sport_default = params[:sport_id]
    end

    @events = @events.paginate(:per_page => 10, :page => params[:page])

   respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @event }
    end
  end 

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params.require(:user).permit(:name, :email, :avatar, :password, :password_confirmation))

    respond_to do |format|
      if @user.save
        format.html {
          log_in @user
          redirect_to @user, notice: 'Congratulations on joining Off the Bench!
            Your profile information is below.'
        }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end 

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Your bio was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def user_prefs
    @user = current_user
  end

  def user_prefs_new
    @user_pref = UserPref.new
  end

  def user_prefs_create
    @user_pref = UserPref.new(user_pref_params)
    if @user_pref.save
      redirect_to current_user, notice: "Notification event added!"
    else
      render :user_prefs_new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :bio, :avatar)
    end

    def user_pref_params
      puts "*************#{params}***************"
      params.require(:user_pref).permit(:user_id, :sport_id, :start_time, :end_time, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday)
    end
    
end
