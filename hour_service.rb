class HourService

  DATA_FILE = "data/hours.json"

  def self.delete
    File.delete(DATA_FILE) if File.exist?(DATA_FILE)
  end

  def self.fetch
    begin
      hours_json = File.read(DATA_FILE)
    rescue Errno::ENOENT
      return HourService.blank_hash
    end

    JSON.parse(hours_json)
  end

  def self.save hours_hash
    File.write(DATA_FILE, hours_hash.to_json )
  end

  def self.blank_hash
   {
     "monday"   => {"start"=>"", "end"=>""},
     "tuesday"  => {"start"=>"", "end"=>""},
     "wednesday"=> {"start"=>"", "end"=>""},
     "thursday" => {"start"=>"", "end"=>""},
     "friday"   => {"start"=>"", "end"=>""}
   }
  end

end
