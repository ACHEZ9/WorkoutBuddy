if Rails.env.production?
  if ENV["REDISCLOUD_URL"]
      $redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
  end
elsif Rails.env.development?
  $redis = Redis.new(:url => "redis://:cosi166b@pub-redis-18862.us-east-1-2.1.ec2.garantiadata.com:18862")
end