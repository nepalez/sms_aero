class SmsAero
  operation :check_senders do
    option :sign, FilledString

    path  "senders"
    query { { sign: sign } }

    response(200) { |*res| Response::WithSenders.build(*res) }
  end
end
