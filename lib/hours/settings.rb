
require 'psych'

class Settings

  def self.base_uri()
    get_setting('base_uri')
  end

  def self.api_key()
    get_setting('api_key')
  end

  def self.user()
    get_setting('user')
  end

  def self.password()
    get_setting('password')
  end

  private

  def self.get_setting(name)
    value = @@settings[name]
    raise "unable to load setting \"#{name}\"" if value.nil?
    value
  end

  @@settings = Psych.load_file('settings.yml')
  #def self.settings()
  #  if @@settings = nil
  #    @@settings =
  #  end
  #  @@settings
  #end

end
