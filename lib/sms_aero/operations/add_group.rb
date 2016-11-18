class SmsAero
  operation :add_group do
    documentation "https://smsaero.ru/api/description/#groups"

    path { "addgroup" }

    query do
      attribute :group, Types::FilledString
    end
  end
end
