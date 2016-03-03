class Event < ActiveRecord::Base
  has_many :users
  scope :search, ->(search) {  where('name LIKE ?', "%#{search}%") }

	# def self.search(search)
	#   if search
	#     where('name LIKE ?', "%#{search}%")
	#   else
	#     scoped
	#   end
	# end

end


