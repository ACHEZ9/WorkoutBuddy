class Event < ActiveRecord::Base
  has_many :activities
  has_many :users, :through => :activities
  has_many :comments
  belongs_to :sport

  validates :location, presence: true
  validates :date, :time, presence: true
  validates :sport, presence: true
  validate :event_in_past

  before_save :get_dow
  after_create :send_notifications

  attr_accessor :distance_from

  # has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # scope :search, ->(search) {  where('events.name LIKE ?', "%#{search}%") }

  geocoded_by :location
  after_validation :geocode, if: ->(obj){ !Rails.env.test? and obj.location.present? and obj.location_changed? }

  def date_time_display
    self.date.strftime("%a %b %d") + " at " + self.time.strftime("%I:%M %p")
  end

  def reset_password?
    new_record? || password.present?
  end

  def get_dow
    self.dow = self.date.wday
  end

  def send_notifications
    NotificationsJob.perform_async(self)
  end

  def event_in_past
    if !self.date.blank? && self.date < Date.today
      errors.add(:date, "can't be in the past")
    end
  end

end
