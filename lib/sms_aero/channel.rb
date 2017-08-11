class SmsAero::Channel < String
  extend SmsAero::Callable

  def self.new(value)
    value ? super(value) : Dry::Initializer::UNDEFINED
  end

  private

  def initialize(value)
    channel = value.to_s
    return super(channel) if %w(1 2 3 4 6).include? channel
    raise "Incorrect value #{channel} for channel"
  end
end
