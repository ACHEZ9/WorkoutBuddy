class Sport < ActiveRecord::Base
  has_many :userSports
  has_many :players, :through => :userSports
  has_many :events
  validates :name, presence: true
end
