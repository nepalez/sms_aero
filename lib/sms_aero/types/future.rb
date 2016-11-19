module SmsAero::Types
  # Describes coercible Unix time in future
  Future = Strict::Int.constructor do |value|
    begin
      error = TypeError.new "#{value.inspect} is not a valid time in future"

      time = value.to_time              if     value.respond_to? :to_time
      time ||= ::Time.parse(value.to_s) unless value.is_a? Numeric
      number = time.to_i

      number > ::Time.now.to_i ? number : raise(error)
    rescue
      raise error
    end
  end
end
