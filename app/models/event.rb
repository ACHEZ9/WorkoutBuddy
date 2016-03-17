class Event < ActiveRecord::Base
  has_many :activities
  has_many :users, :through => :activities
  belongs_to :sport

  validates :name, presence: true, length: { maximum: 50 }
  validates :location, presence: true
  validates :date, :time, presence: true

  before_save :get_dow

  # has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  scope :search, ->(search) {  where('name LIKE ?', "%#{search}%") }

  geocoded_by :location
  after_validation :geocode, if: ->(obj){ obj.location.present? and obj.location_changed? }

  def reset_password?
    new_record? || password.present?
  end

  def get_dow
    self.dow = self.date.wday
  end

end
