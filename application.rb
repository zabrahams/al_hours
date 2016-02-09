require 'bundler'
Bundler.require

require_relative "./hour_service.rb"

get "/" do
  erb :index
end

get "/hours" do
  hours = HourService.fetch
  { hours: hours }.to_json
end

post "/hours" do
  request.body.rewind
  puts request.body.read
  request.body.rewind
  hours_hash = JSON.parse(request.body.read)
  HourService.save(hours_hash["hours"])
  { hours: hours_hash }.to_json
end

delete "/hours" do
  HourService.delete
  {}.to_json
end
