class SmsAero
  class Response::WithTariff < Response
    option :reason, SmsAero::Tariff, optional: true, as: :tariff
  end
end
