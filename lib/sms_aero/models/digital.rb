module SmsAero::Digital
  extend SmsAero::Callable

  def self.new(value)
    value ? 1 : 0
  end
end
