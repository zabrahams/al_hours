require 'csv'

class HourService

  DATA_FILE = "data/hours.csv"

  def self.delete
    File.delete(DATA_FILE)
  end

  def self.headers
    [
      "monday_start",
      "monday_end",
      "tuesday_start",
      "tuesday_end",
      "wednesday_start",
      "wednesday_end",
      "thursday_start",
      "thursday_end",
      "friday_start",
      "friday_end",
    ]
  end

  def self.fetch
    begin
      csv_file = CSV.open(DATA_FILE, "rb", headers: true)
    rescue Errno::ENOENT
      return HourService.blank_hash
    end
    csv = csv_file.read
    HourService.pop_out csv[0].to_hash
  end

  def self.save hours_hash
    flat_hash = HourService.flatten hours_hash
    CSV.open(DATA_FILE, "wb", headers: true) do |csv|
      csv << HourService.headers
      csv << HourService.headers.map { |header| flat_hash[header] }
    end
  end

  def self.flatten hours_hash
    flat_hash = {}
    hours_hash.keys.each do |k1|
      hours_hash[k1].each do |k2, v|
        flat_hash["#{k1}_#{k2}"] = v
      end
    end

    flat_hash
  end

  def self.pop_out flat_hash
    hours_hash = Hash.new { |h, k| h[k] = Hash.new }
    flat_hash.each do |key, value|
      k1, k2 = key.split("_")
      hours_hash[k1][k2] = value
    end

    hours_hash
  end

  def self.blank_hash
    blank_hash = {}
    HourService.headers.each { |header| blank_hash[header] = nil }
    HourService.pop_out blank_hash
  end

end
