class SmsAero
  class Tariff < Evil::Client::Model
    attributes type: Types::Coercible::Float, optional: true do
      attribute :"Direct channel",  as: :direct
      attribute :"Digital channel", as: :digital
    end
  end
end
