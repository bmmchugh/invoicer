
require 'uri'
require 'net/http'
require 'json'

class LessApi

  def api_hash
    hash = {}
    self.instance_variables.each do |var|
      name = self.class.api_field_name(var.to_s.delete('@'))
      unless name.nil?
        value = self.instance_variable_get(var)
        unless value.nil?
          hash["#{self.class.api_name()}[#{name}]"] = value
        end
      end
    end

    hash
  end

  def api_hash=(hash)

    hash.each do |key, value|

      name = self.class.model_field_name(key)

      if !name.nil? and self.respond_to?("#{name}=")
        self.send("#{name}=", value)
      end

    end

  end

  def save(path_args = {})

    #puts "Saving with #{path_args.inspect}"

    if self.respond_to?(:id) && self.id.nil?
      response_hash = JSON.parse(self.class.post([self.class.api_path(path_args)], {}, self.api_hash))
      self.api_hash = response_hash
    else
      raise "Don't know how to save #{self.class.name}"
    end

  end

  def self.api_field_name(model_name)
    model_name
  end

  def self.model_field_name(api_field_name)
    api_field_name
  end

  def self.load(id, path_args = {})

    response_hash = JSON.parse(get([api_path(path_args), id]))

    obj = self.new()
    obj.api_hash = response_hash

    obj
  end

  def self.api_path(path_args = {})
    unless api_name().empty?
      "/#{api_name()}s"
    else
      api_name()
    end
  end

  def self.api_name()
    ''
  end

  def self.get(path, params={})
    uri = buildUri(path, params)

    #puts "GET #{uri.to_s}"
    request = Net::HTTP::Get.new(uri)

    send_request(request, uri)
  end

  def self.post(path, params={}, form_data={})
    uri = buildUri(path, params)

    #puts "POST #{uri.to_s}"
    request = Net::HTTP::Post.new(uri)
    unless form_data.empty?
      request.set_form_data(form_data)
    end

    send_request(request, uri)
  end

  def self.send_request(request, uri)
    request.basic_auth Settings.user, Settings.password
    response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http|
      http.request(request)
    end
    raise response.body unless response.is_a? Net::HTTPSuccess
    response.body
  end

  def self.buildUri(path, params={})
    uri = URI(Settings.base_uri)
    #puts uri.to_s
    uri_path = ''
    unless path.nil?
      uri_path << [path].flatten.join('/')
    end
    uri_path << '.json'
    uri = URI.join(uri, uri_path)
    params[:api_key] = Settings.api_key
    uri.query = URI.encode_www_form(params) unless params.empty?
    uri
  end

end
