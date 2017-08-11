class SmsAero::FilledString < String
  extend SmsAero::Callable

  private

  def initialize(value)
    string = value.to_s
    raise "blank value" if string == ""
    super string
  end
end
