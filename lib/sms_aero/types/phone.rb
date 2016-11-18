module SmsAero::Types
  # Describes a valid phone containing digits without lead zeros
  #
  # @example
  #   SmsAero::Types::Phone["07 (123) 134-12-08"] # => "71231341208"
  #   SmsAero::Types::Phone["008"] # raises #<Dry::Types::ConstraintError ...>
  #
  Phone = Strict::String.constrained(format: /\A\d{11,13}\z/)
                        .constructor do |value|
                          value.to_s.scan(/\d/).join[/[^0].*/].to_s
                        end
end
