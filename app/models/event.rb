class Event < ActiveRecord::Base
  has_many :activities
  has_many :users, :through => :activities

  validates :name, presence: true, length: { maximum: 50 }

  # has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def reset_password?
    new_record? || password.present?
  end
  has_many :users
  validates :location, presence: true
  scope :search, ->(search) {  where('name LIKE ?', "%#{search}%") }

	# def self.search(search)
	#   if search
	#     where('name LIKE ?', "%#{search}%")
	#   else
	#     all
	#   end
	# end
  geocoded_by :location
  after_validation :geocode, if: ->(obj){ obj.location.present? and obj.location_changed? }

end
