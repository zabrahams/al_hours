require 'bundler'
Bundler.require

require_relative "./hour_service.rb"

RATE = 15

get "/" do
  raw_hours = HourService.fetch
  @hours = decorate raw_hours
  erb :index
end

post "/" do
  HourService.save(params[:hours])
  @hours = decorate params[:hours]
  erb :index
end

delete "/" do
  HourService.delete
  @hours = decorate HourService.blank_hash
  erb :index
end

def decorate  hours
  hours.keys.each do |key|
    start = hours[key]["start"]
    fin = hours[key]["end"]
    if start && fin && fin > start
      hours[key]["total"] = ((Time.parse(fin) - Time.parse(start))/3600).round(3)
    end
  end

  hours["total"] = hours.map { |k, v| v["total"] }.reject(&:nil?).inject(0, :+)
  hours["dollars"] = (hours["total"].to_f * RATE).round(2)

  hours
end
