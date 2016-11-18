class SmsAero
  operation :check_tariff do
    documentation "https://smsaero.ru/api/description/#get-balance"

    path { "checktarif" }

    response :success, 200, format: :json do
      attribute :result, Types::FilledString
      attribute :reason, Tariff, as: :tariff
    end
  end
end
