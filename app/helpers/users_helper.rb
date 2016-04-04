module UsersHelper

  def notification_count 
    if logged_in?
      @count ||= $redis.llen("notifications:user:#{current_user.id}")
      @count = "" if @count == 0
      
      return @count
    end
  end

  def clear_notification_count
    @count = nil
  end
  
end
