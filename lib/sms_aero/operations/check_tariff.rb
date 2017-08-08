class SmsAero
  operation :check_tariff do
    path "checktarif"

    response(200) { |*res| Response::WithTariff.build(*res) }
  end
end
