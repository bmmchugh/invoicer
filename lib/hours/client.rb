
class Client < LessApi
  attr_accessor :id, :first_name, :last_name, :company_name, :email

  def self.api_name()
    'contact'
  end

end
