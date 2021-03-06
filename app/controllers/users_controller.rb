class UsersController < ApplicationController
  before_action :set_user, except: [:new, :index, :create, :notifications, :delete_notification, :recommendations]
  before_action :check_user, only: [:edit, :user_prefs, :user_prefs_new, :user_prefs_create ]
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
    @events = current_user.events
    @e_others = Event.all
    @reccos = current_user.get_reccomendations(@events, @e_others)
  end 

  # GET /users/1
  # GET /users/1.json
  def show
    @user = current_user
    @events = current_user.events
    @upcoming_events = @events.where("? <= date", Date.today).order(date: :asc, time: :asc)
    @e_others = Event.all
    @reccos = current_user.get_reccomendations(@events, @e_others)
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

  def notifications
    @notifications = current_user.get_notifications
  end

  def delete_notification
    current_user.delete_notification(params[:id])
    clear_notification_count(current_user.id)
    
    respond_to do |format|
      format.html {redirect_to notifications_users_path}
      format.js
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
      params.require(:user_pref).permit(:user_id, :sport_id, :start_time, :end_time, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday)
    end

    def check_user
      if !Rails.env.test? && @user.id != current_user.id
        render_404
      end
    end
    
end