module UsersHelper

  def notification_count 
    if logged_in? && !Rails.env.test?
      @count ||= $redis.llen("notifications:user:#{current_user.id}")
      @count = "" if @count == 0

      return @count
    else
      return ""
    end
  end

  def clear_notification_count
    @count = nil
  end
  
end
