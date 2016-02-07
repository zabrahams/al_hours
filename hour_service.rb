class HourService

  DATA_FILE = "data/hours.csv"

  def self.delete
    File.delete(DATA_FILE)
  end

  def self.headers
    [
      "monday_start",
      "monday_end",
      "monday_hours",
      "tuesday_start",
      "tuesday_end",
      "tuesday_hours",
      "wednesday_start",
      "wednesday_end",
      "wednesday_hours",
      "thursday_start",
      "thursday_end",
      "thursday_hours",
      "friday_start",
      "friday_end",
      "friday_hours",
    ]
  end

  def self.fetch
    csv_file = CSV.open(DATA_FILE, "rb", headers: true)
    csv = csv_file.read
    csv[0].to_hash
  end

  def self.save hours_hash
    CSV.open(DATA_FILE, "wb", headers: true) do |csv|
      csv << HourService.headers
      csv << HourService.headers.map { |header| hours_hash[header] }
    end
  end

end
