class SmsAero
  operation :send_sms do
    documentation "https://smsaero.ru/api/description/#send-sms"

    path do |test: false, **|
      test ? "testsend" : "send"
    end

    query do
      attribute :text,    Types::FilledString
      attribute :to,      Types::Phone
      attribute :digital, Types::Digital, optional: true
      attribute :date,    Types::Future,  optional: true
      attribute :type,    Types::Channel,
                default: -> (*) do
                  case digital
                  when Dry::Initializer::UNDEFINED then 2
                  else Dry::Initializer::UNDEFINED
                  end
                end
    end

    response :success, 200, format: :json, model: Answer do
      attribute :id, Types::Coercible::String
    end
  end
end
