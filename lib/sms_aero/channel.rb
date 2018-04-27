class SmsAero::Channel < String
  extend SmsAero::Callable

  def self.new(value)
    value ? super(value) : Dry::Initializer::UNDEFINED
  end

  private

  def initialize(value)
    channel = value.to_s
    return super(channel) if %w(4 5 6 7 8).include? channel
    raise "Incorrect value #{channel} for channel"
  end
end
