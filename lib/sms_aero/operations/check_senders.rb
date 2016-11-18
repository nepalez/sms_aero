class SmsAero
  operation :check_senders do
    documentation "https://smsaero.ru/api/description/#signs"

    path { "senders" }

    query do
      attribute :sign, Types::FilledString
    end

    response :success, 200, format: :json, model: Answer do
      attribute :data, Types::Array.member(Types::FilledString)
    end
  end
end
