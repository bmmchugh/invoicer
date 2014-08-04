
class Invoice < LessApi

  attr_accessor :id, :reference_name_number, :created_at, :updated_at,
                :proposal_template_id, :header, :first_sent, :sent_at,
                :sent_to, :email_heading, :email_subject, :proposal_id,
                :bank_account_id, :sales_tax_amount, :sales_tax_percentage,
                :total, :payment_total, :business_id, :contact_id,
                :due_on, :show_paypal, :currency_id, :amount_due

  def self.api_name()
    'invoice'
  end

end
