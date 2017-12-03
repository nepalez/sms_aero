module SmsAero::HlrStatus
  extend SmsAero::Callable

  def self.new(value)
    case value.to_i
    when 1 then :available
    when 2 then :unavailable
    else :nonexistent
    end
  end
end
