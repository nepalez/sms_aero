class SmsAero
  operation :check_sign do
    option :sign, FilledString

    path  "sign"
    query { { sign: sign } }

    response(200) do |_, _, body|
      data = JSON.parse(body.first)
      Response::WithStatuses.new(data: data)
    end
  end
end
