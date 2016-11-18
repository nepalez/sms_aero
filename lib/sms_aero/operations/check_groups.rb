class SmsAero
  operation :check_groups do
    documentation "https://smsaero.ru/api/description/#groups"

    path { "checkgroup" }

    response :success, 200, format: :json do
      attribute :result, Types::FilledString
      attribute :reason, Types::Hash, as: :channels
    end
  end
end
