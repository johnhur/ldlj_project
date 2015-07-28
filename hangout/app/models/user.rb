class User < ActiveRecord::Base

	validates :email, presence: true
	validates :password, presence: true
	# we will add in additional validations later on
	
	# added avatar information 
	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>"}, :default_url => "/images/:style/missing.png" 
	# validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*Z/
	validates_attachment :avatar, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

	has_many :favorites, dependent: :destroy
	has_many :places, through: :favorites

	has_secure_password
end
