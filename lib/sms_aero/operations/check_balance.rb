class SmsAero
  operation :check_balance do
    path "balance"
    response(200) { |*res| Response::WithBalance.build(*res) }
  end
end
