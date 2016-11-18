class SmsAero
  operation :delete_phone do
    documentation "https://smsaero.ru/api/description/#contacts"

    path { "delphone" }

    query do
      attribute :phone, Types::Phone
      attribute :group, Types::FilledString, optional: true
    end
  end
end
