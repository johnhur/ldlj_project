class User < ActiveRecord::Base

	validates :email, presence: true
	validates :password, presence: true
	# we will add in additional validations later on

	has_many :favorites, dependent: :destroy
	has_many :places, through: :favorites

	has_secure_password
end
