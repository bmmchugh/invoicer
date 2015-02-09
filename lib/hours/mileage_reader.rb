
require 'csv'

class MileageReader

  def self.read(file_name, &block)

    read_items = false

    CSV.foreach(file_name) do |row|

      if read_items == false
        if row[0] == 'Date'
          read_items = true
        end
      else
        mileage_log = MileageLog.new
        mileage_log.trip_date = row[0]
        mileage_log.vehicle_id = row[1]
        mileage_log.trip_start = row[2]
        mileage_log.trip_end = row[3]
        mileage_log.notes = row[4]
        yield(mileage_log)
      end
    end

  end

  def self.get_contact_id(file_name)

    contact_id = nil
    CSV.foreach(file_name) do |row|
      if row[0] == 'Client'
        contact_id = row[2]
        break
      end
    end

    contact_id

  end

  def self.get_template_id(file_name)

    template_id = nil
    CSV.foreach(file_name) do |row|
      if row[0] == 'Invoice ID'
        template_id = row[2]
        break
      end
    end

    template_id

  end

end
