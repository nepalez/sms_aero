class SmsAero
  operation :add_blacklist do
    documentation "https://smsaero.ru/api/description/#balcklist"

    path { "addblacklist" }

    query do
      attribute :phone, Types::Phone
    end
  end
end
