class Event < ActiveRecord::Base
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


