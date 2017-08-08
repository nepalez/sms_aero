class SmsAero
  operation :check_groups do
    path "checkgroup"
    response(200) { |*res| Response::WithGroups.build(*res) }
  end
end
