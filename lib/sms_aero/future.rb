# Coercible Unix time in future
class SmsAero::Future < String
  extend SmsAero::Callable

  private

  def initialize(value)
    time = value.to_time         if     value.respond_to? :to_time
    time ||= ::Time.parse(value) unless value.is_a? Numeric
    number = time.to_i
    return super(number.to_s) if number > ::Time.now.to_i
    raise "#{value} is a time in the past, not in the future"
  rescue
    raise "#{value} is not a valid time"
  end
end
