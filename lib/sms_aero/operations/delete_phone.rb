class SmsAero
  operation :delete_phone do
    documentation "https://smsaero.ru/api/description/#contacts"

    path { "delphone" }

    query do
      attribute :phone, Types::Phone
      attribute :group,
                Types::Strict::String.constrained(filled: true),
                optional: true
    end
  end
end
