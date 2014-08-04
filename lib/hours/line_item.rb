
class LineItem < LessApi
  attr_accessor :id, :created_at, :updated_at, :proposal_id, :unit_price, :line, :additional_description,
                :quantity, :position, :business_id, :total, :subtotal, :taxes_total, :sales_tax_ids


  def save(path_args = {})
    super(:proposal_id => self.proposal_id)
  end

  def self.api_path(path_args = {})

    proposal_id = if path_args.has_key?(:proposal_id)
                    path_args[:proposal_id]
                  else
                    path_args['proposal_id']
                  end

    if proposal_id.nil?
      raise "Unable to create an api path without proposal_id"
    end

    ['proposals', proposal_id, "#{self.api_name}s"].join('/')
  end

  def self.api_name
    'line_item'
  end

end
