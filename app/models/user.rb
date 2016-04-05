class User < ActiveRecord::Base
  has_many :activities
  has_many :events, :through => :activities
  has_many :userSports
  has_many :sports, :through => :userSports
  has_many :userPrefs

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

end
