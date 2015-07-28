class Place < ActiveRecord::Base

	validates :business_name, presence: true

	has_many :favorites, dependent: :destroy
	has_many :users, through: :favorites

	has_many :comments, dependent: :destroy
	has_many :users, through: :comments

	def self.new_place(location, business)
		@new_yelp = Yelp::Client.new({ consumer_key: Rails.application.secrets[:YELP_CONSUMER_KEY],
                            consumer_secret: Rails.application.secrets[:YELP_CONSUMER_SECRET],
                            token: Rails.application.secrets[:YELP_TOKEN],
                            token_secret: Rails.application.secrets[:YELP_TOKEN_SECRET]
                         })
	end 
end
