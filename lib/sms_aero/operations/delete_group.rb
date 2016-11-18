class SmsAero
  operation :delete_group do
    documentation "https://smsaero.ru/api/description/#groups"

    path { "delgroup" }

    query do
      attribute :group, Types::FilledString
    end
  end
end
