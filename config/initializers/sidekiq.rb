if Rails.env == "production"
  Sidekiq.configure_server do |config|
    config.redis = { :url => 'redis://rediscloud:HUOqQ2kp6uL59i1e@pub-redis-17872.us-east-1-2.3.ec2.garantiadata.com:17872' }
  end

  Sidekiq.configure_client do |config|
    config.redis = { :url => 'redis://rediscloud:HUOqQ2kp6uL59i1e@pub-redis-17872.us-east-1-2.3.ec2.garantiadata.com:17872' }
  end
end
