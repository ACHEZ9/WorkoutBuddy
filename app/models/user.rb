class User < ActiveRecord::Base
  has_many :activities
  has_many :events, :through => :activities
  has_many :userSports
  has_many :sports, :through => :userSports
  has_many :userPrefs
  has_many :comments

  before_save{ self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 4}, on: :create, unless: :reset_password?

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def reset_password?
    new_record? || password.present?
  end

  def get_notifications
    event_ids = $redis.lrange("notifications:user:#{self.id}", 0, -1)
    Event.find(event_ids)
  end

  def delete_notification(value)
    $redis.lrem("notifications:user:#{self.id}", 1, value)
  end

  def attend_event(event)
    self.events << event
    if !Rails.env.test?
      $redis.lrem("notifications:user:#{self.id}", 1, event.id)
      Rails.cache.delete("/notifications/#{self.id}")
    end
  end

  def unattend_event(event)
    self.events.destroy(event)
  end

  def get_reccomendations(userEvents, allEvents)
    @reccos = Array.new 
    arb_start_size = 5
    allEvents = filter_by_location(userEvents, arb_start_size, 5)
    allEvents.each do|e|
      unless userEvents.include? e
        @reccos << e
      end  
    end
    shrink_reccos(userEvents)
    return @reccos
  end 

  def shrink_reccos (userEvents)
    #new_or_old = 0 # for testing 
    new_or_old = rand(2) # if 1, reccomend new sports, if 0 reccomend sports the user likes already 
    filter_by_sport(userEvents, new_or_old)
    filter_by_time(userEvents)
  end 

  def filter_by_sport(userEvents, new_or_old)
    new_reccos = Array.new
    curr_sports = Array.new # would be more efficient as a Set, but let's go simple for now 
    userEvents.each do|u|
      curr_sports << u.sport_id 
    end 
    if curr_sports.size() == 0 # Handles the case of when a user doesn't events to use
      new_or_old = 1
    end
    @reccos.each do |e|
      temp = e.sport_id 
      if new_or_old == 1 # reccomend new sports
        unless curr_sports.include? temp 
          new_reccos << e
        end 
      else #reccomend old sports 
        if curr_sports.include? temp 
          new_reccos << e
        end
      end 
    end

    if new_reccos.size > 0
      @reccos = new_reccos
    end  
  end 

  def filter_by_location(userEvents, size, miles)
    if userEvents.size() > 0
      pick = rand(userEvents.size)
      choice = userEvents.at(pick)
      new_events = Event.near(choice.location, miles)
    else 
      new_events = Event.all
    end 

    return new_events
  end 

  def filter_by_time(userEvents)
    new_reccos = Array.new 
    times = Array.new 
    userEvents.each do |u|
      arr = Array.new
      arr << u.date
      arr << u.time 
      times << arr
    end 

    @reccos.each do |e|
      arr = Array.new
      arr << e.date 
      arr << e.time 

      unless times.include? arr 
        new_reccos << e
      end 
    end 

    if new_reccos.size() > 0 
      @reccos = new_reccos
    end 
  end 
end
