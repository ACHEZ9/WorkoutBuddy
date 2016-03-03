class Event < ActiveRecord::Base
  has_many :users

	def self.search(search)
	  if search
	    where('name LIKE ?', "%#{search}%")
	  else
	    scoped
	  end
	end

end


