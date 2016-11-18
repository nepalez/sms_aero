class SmsAero
  operation :check_sign do
    documentation "https://smsaero.ru/api/description/#signs"

    path { "sign" }

    query do
      attribute :sign, Types::FilledString
    end

    response :success, 200, format: :json do
      attribute :data, Types::Array.member(Types::SignStatus), as: :statuses
    end
  end
end
