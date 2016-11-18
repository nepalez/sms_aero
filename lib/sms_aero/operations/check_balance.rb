class SmsAero
  operation :check_balance do
    documentation "https://smsaero.ru/api/description/#get-balance"

    path { "balance" }

    response :success, 200, format: :json, model: Answer do
      attribute :balance, Types::Coercible::Float
    end
  end
end
