class SmsAero
  operation :add_group do
    documentation "https://smsaero.ru/api/description/#groups"

    path { "addgroup" }

    query do
      attribute :group, Types::Strict::String.constrained(filled: true)
    end
  end
end
