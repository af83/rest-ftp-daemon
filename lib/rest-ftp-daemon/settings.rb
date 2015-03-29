# Configuration class
class Settings < Settingslogic
  # Read configuration
  namespace (defined?(APP_ENV) ? APP_ENV : "production")
  source ((File.exists? APP_CONF) ? APP_CONF : Hash.new)
  suppress_errors true

  # Compute my PID filename
  def pidfile
    self["pidfile"] || "/tmp/#{APP_NAME}.port#{self['port'].to_s}.pid"
  end

  # Direct access to any depth
  def at *path
    path.reduce(Settings) {|m,key| m && m[key.to_s] }
  end

  # Dump whole settings set to readable YAML
  def dump
    self.to_hash.to_yaml( :Indent => 4, :UseHeader => true, :UseVersion => false )
  end

  def init_defaults
    Settings['host'] ||= `hostname`.chomp.split('.').first
  end

end
