class SmsAero::Tariff
  extend  Dry::Initializer
  extend  SmsAero::Callable
  include SmsAero::Optional

  option :"Direct channel",  proc(&:to_f), optional: true, as: :direct
  option :"Digital channel", proc(&:to_f), optional: true, as: :digital
end
