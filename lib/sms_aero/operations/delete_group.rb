class SmsAero
  operation :delete_group do
    documentation "https://smsaero.ru/api/description/#groups"

    path { "delgroup" }

    query do
      attribute :group, Types::Strict::String.constrained(filled: true)
    end
  end
end
