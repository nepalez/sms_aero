module SmsAero::Types
  # Describes statuses of the sign
  SignStatus = Strict::String.constrained included_in: %w(
    accepted
    approved
    rejected
    pending
  )
end
