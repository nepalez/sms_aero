class SmsAero
  operation :send_sms do
    documentation "https://smsaero.ru/api/description/#send-sms"

    path do |test: false, **|
      test ? "testsend" : "send"
    end

    query model: Sms do
      attribute :to, Types::Phone
    end

    response :success, 200, format: :json, model: Answer do
      attribute :id, Types::Coercible::String
    end
  end
end
