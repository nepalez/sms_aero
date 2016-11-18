class SmsAero
  class Tariff < Evil::Client::Model
    attribute :"Direct channel",
              Types::Coercible::Float,
              as: :direct,
              optional: true

    attribute :"Digital channel",
              Types::Coercible::Float,
              as: :digital,
              optional: true
  end
end
