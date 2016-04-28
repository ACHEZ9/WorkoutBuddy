class EventCleanupJob 
  include SuckerPunch::Job
  
  # Remove events that have occurred more than x days ago
  def perform(days_ago)
    ActiveRecord::Base.connection_pool.with_connection do
      Event.where("date <= ?", Date.today - days_ago).destroy
    end
  end
end
