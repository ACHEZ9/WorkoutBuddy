class NotificationsJob 
  include SuckerPunch::Job
  include UsersHelper
  
  def perform(event)
    ActiveRecord::Base.connection_pool.with_connection do
      @preferences = UserPref.select(:user_id).where("(sport_id = ? or sport_id IS NULL) and #{Date::DAYNAMES[event.dow]} =  ? and start_time <= ? and end_time >= ?", event.sport_id, true, event.time, event.time).group(:user_id)
      @preferences.each do |pref|
        user_id = pref.user_id.to_s
        $redis.lpush("notifications:user:#{user_id}", event.id)
        clear_notification_count(user_id)
        #Send a push that a new event was created
        Pusher.trigger('notifications_channel', 'notification_event_' + user_id, {event_id: event.id})
      end
    end
  end
end
