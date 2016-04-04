if Rails.env.production?
  if ENV["REDISCLOUD_URL"]
      $redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
  end
elsif Rails.env.development?
  #Set environment variable or replace with the url of your redis service
  $redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
end