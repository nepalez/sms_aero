class SmsAero::Group < String
  extend SmsAero::Callable

  private

  def initialize(value)
    group = value.to_s
    raise "'#{value}' is not a valid group name" unless group[/^\w{1,20}$/]
    super group
  end
end
