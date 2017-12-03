class SmsAero::Birthday < String
  extend SmsAero::Callable

  private

  def initialize(value)
    date = value.respond_to?(:to_date) ? value.to_date : Date.parse(value)
    super date.strftime "%Y-%m-%d"
  rescue StandardError
    raise "#{value} is not a valid value for a birthday"
  end
end
