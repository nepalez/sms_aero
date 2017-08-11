class SmsAero::Phone < String
  extend SmsAero::Callable

  private

  def initialize(value)
    phone = value.to_s.scan(/\d/).join[/[^0].*/].to_s
    raise "'#{value}' is not a valid phone" unless phone[/^\d{11,13}$/]
    super phone
  end
end
