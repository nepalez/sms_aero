module SmsAero::Types
  FilledString = Coercible::String.constrained(filled: true)
end
