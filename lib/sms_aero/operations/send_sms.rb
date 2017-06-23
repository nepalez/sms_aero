class SmsAero
  operation :send_sms do |settings|
    documentation "https://smsaero.ru/api/description/#send-sms"

    path do |test: false, **|
      settings.test || test ? "testsend" : "send"
    end

    query model: Sms do
      attribute :to, Types::Phone
    end

    response :success, 200, format: :json, model: Answer do
      attribute :id, proc(&:to_s)
      attribute :success, default: proc { id != "" }
    end

    response :failure, 200, format: :json, model: Answer do
      attribute :success, default: proc { false }
    end
  end
end
