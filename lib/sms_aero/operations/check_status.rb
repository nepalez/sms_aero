class SmsAero
  operation :check_status do
    documentation "https://smsaero.ru/api/description/#check-status"

    path { "status" }

    query do
      attribute :id, Types::Coercible::String.constrained(filled: true)
    end
  end
end
