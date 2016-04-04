class NotificationsJob 
  include SuckerPunch::Job
  
  def perform(event)
    ActiveRecord::Base.connection_pool.with_connection do
      @preferences = UserPref.where("(sport_id = ? or sport_id IS NULL) and #{Date::DAYNAMES[event.dow]} =  ? and start_time <= ? and end_time >= ?", event.sport_id, true, event.time, event.time).group(:user_id)
      @preferences.each do |pref|
        user = pref.user
        $redis.lpush("notifications:user:#{user.id}", event.id)
        # $redis.llen("notifications:user:#{user.id}")
        # $redis.lrem("notifications:user:#{user.id}", 1, event.id)
        # $redis.lrange("notifications:user:#{user.id}", 0, -1)
      end
    end
  end
end
