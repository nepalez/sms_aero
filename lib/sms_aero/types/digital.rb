module SmsAero::Types
  # Converts any value to either 1 or 0 flag for digital sending channel
  #
  # @example
  #   SmsAero::Types::Digital[true] # => 1
  #
  Digital = Strict::Int.constructor { |value| value ? 1 : 0 }
end
