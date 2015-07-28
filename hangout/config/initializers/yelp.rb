Yelp.client.configure do |config|
  config.consumer_key = Rails.application.secrets[:YELP_CONSUMER_KEY]
  config.consumer_secret = Rails.application.secrets[:YELP_CONSUMER_SECRET]
  config.token = Rails.application.secrets[:YELP_TOKEN]
  config.token_secret = Rails.application.secrets[:YELP_TOKEN_SECRET]
end

# Yelp.client.configure do |config|
#   config.consumer_key = ENV['YELP_CONSUMER_KEY']
#   config.consumer_secret = ENV['YELP_CONSUMER_SECRET']
#   config.token = ENV['YELP_TOKEN']
#   config.token_secret = ENV['YELP_TOKEN_SECRET']
# end

# Yelp.client.configure do |config|
#   config.consumer_key = YOUR_CONSUMER_KEY
#   config.consumer_secret = YOUR_CONSUMER_SECRET
#   config.token = YOUR_TOKEN
#   config.token_secret = YOUR_TOKEN_SECRET
# end


# client = Yelp::Client.new({ consumer_key: Rails.application.secrets[:YELP_CONSUMER_KEY],
#                             consumer_secret: Rails.application.secrets[:YELP_CONSUMER_SECRET],
#                             token: Rails.application.secrets[:YELP_TOKEN],
#                             token_secret: Rails.application.secrets[:YELP_TOKEN_SECRET]
#                          })