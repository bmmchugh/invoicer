
require 'csv'

class LineItemReader

  def self.read(file_name, &block)

    read_items = false
    bill_rate = nil

    CSV.foreach(file_name) do |row|

      if read_items == false
        if row[0] == 'Date'
          read_items = true
        end
        if row[0] == 'Bill Rate'
          bill_rate = row[1]
        end
      else
        line_item = LineItem.new
        line_item.line = row[0]
        line_item.additional_description = row[2]
        line_item.quantity = row[3]
        line_item.unit_price = bill_rate
        yield(line_item)
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
