class SmsAero
  operation :check_sending do
    documentation "https://smsaero.ru/api/description/#check-status"

    path { "checksending" }

    query do
      attribute :id, Types::Coercible::String.constrained(filled: true)
    end
  end
end
