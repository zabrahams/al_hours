require 'bundler'
Bundler.require

get "/" do
  redis = Redis.new(:host => "127.0.0.1", :port => 6379)
  @hours = redis.get("hours") || 0
  erb :index
end

get "/hours" do
  redis = Redis.new(:host => "127.0.0.1", :port => 6379)
  hours = redis.get("hours") || 0
  { hours: hours }.to_json
end

put "/hours" do
  redis = Redis.new(:host => "127.0.0.1", :port => 6379)
  hours = redis.get("hours")
  hours ||= 0
  puts params
  new_hours = hours.to_i +  params["hours"].to_i
  redis.set("hours", new_hours)
  { hours: new_hours }.to_json
end

delete "/hours" do
  redis = Redis.new(:host => "127.0.0.1", :port => 6379)
  redis.set("hours", 0)
  { hours: 0 }.to_json
end
