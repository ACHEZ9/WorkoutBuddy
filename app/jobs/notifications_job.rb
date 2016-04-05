class NotificationsJob 
  include SuckerPunch::Job
  include UsersHelper
  
  def perform(event)
    ActiveRecord::Base.connection_pool.with_connection do
      @preferences = UserPref.where("(sport_id = ? or sport_id IS NULL) and #{Date::DAYNAMES[event.dow]} =  ? and start_time <= ? and end_time >= ?", event.sport_id, true, event.time, event.time).group(:user_id)
      @preferences.each do |pref|
        user = pref.user
        $redis.lpush("notifications:user:#{user.id}", event.id)
        clear_notification_count(user.id)
        #Send a push that a new event was created
        Pusher.trigger('notifications_channel', 'notification_event_' + user.id.to_s, {event_id: event.id})
      end
    end
  end
end
