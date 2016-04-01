class NotificationsJob 
  include SuckerPunch::Job
  
  def perform(event)
    ActiveRecord::Base.connection_pool.with_connection do
      @preferences = UserPref.where("(sport_id = ? or sport_id = 0) and #{Date::DAYNAMES[event.dow]} =  ? and start_time <= ? and end_time >= ?", event.sport_id, true, event.time, event.time)
      @preferences.each do |pref|
        user = pref.user
        $redis.lpush("notifications:user:#{user.id}", event.id)
        # $redis.llen("notifications:user:#{user.id}")
        # $redis.lrem("notifications:user:#{user.id}", 1, event.id)
      end
    end
  end
end
