class User < ActiveRecord::Base

	validates :email, presence: true
	# we will add in additional validations later on

	has_many :favorites, dependent: :destroy
	has_many :places, through: :favorites

end
