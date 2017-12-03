class SmsAero
  HLR_STATUSES = {
    1 => :available,
    2 => :unavailable,
    3 => :nonexistent
  }.freeze

  operation :hlr do
    documentation "https://smsaero.ru/api/description/#hlr"

    path { "hlr" }

    query { attribute :phone, Types::Phone }

    response :success, 200, format: :json, model: Answer do
      attribute :id, proc(&:to_s)
      attribute :success, default: proc { id != "" }
    end
  end

  operation :hlr_status do
    documentation "https://smsaero.ru/api/description/#hlr"

    path { "hlrStatus" }

    query { attribute :id, Types::Coercible::String.constrained(filled: true) }

    response :success, 200, format: :json, model: Answer do
      attribute :status, -> (s) { HLR_STATUSES[s.to_i] }
    end
  end
end
