class Place < ActiveRecord::Base

	validates :business_name, presence: true

	has_many :favorites, dependent: :destroy
	has_many :users, through: :favorites
end
