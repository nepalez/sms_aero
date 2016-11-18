class SmsAero
  operation :send_to_group do
    documentation "https://smsaero.ru/api/description/#send-sms"

    path { "sendtogroup" }

    query model: Sms do
      attribute :group, Types::FilledString, default: proc { "all" }
    end

    response :success, 200, format: :json, model: Answer do
      attribute :id, Types::Coercible::String, optional: true
    end
  end
end
