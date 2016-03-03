class Event < ActiveRecord::Base
  has_many :users
<<<<<<< HEAD

  validates :name, presence: true, length: { maximum: 50 }

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def reset_password?
    new_record? || password.present?
  end
=======
>>>>>>> 4ea0afc860271afa059208a9e06d74805f6b2068
end
