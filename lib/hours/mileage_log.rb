
class MileageLog < LessApi
  attr_accessor :id, :created_at, :updated_at, :vehicle_id,
    :notes, :miles, :trip_date, :trip_start, :trip_end

  def self.api_name
    'mileage_log'
  end

end

