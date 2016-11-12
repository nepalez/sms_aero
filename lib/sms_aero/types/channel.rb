module SmsAero::Types
  # Describes acceptable channel codes
  Channel = Coercible::Int.constrained included_in: [1, 2, 3, 4, 6]
end
