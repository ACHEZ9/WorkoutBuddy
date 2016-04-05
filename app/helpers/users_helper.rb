module UsersHelper

  def notification_count 
    if logged_in? && !Rails.env.test?
      @count = Rails.cache.fetch("/notifications/#{current_user.id}") do
        $redis.llen("notifications:user:#{current_user.id}")
      end
      # @count ||= $redis.llen("notifications:user:#{current_user.id}")
      @count = "" if @count == 0

      return @count
    else
      return ""
    end
  end

  def clear_notification_count(user_id)
    Rails.cache.delete("/notifications/#{user_id}")
  end
  
end
