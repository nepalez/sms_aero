class SmsAero
  class Response::WithBalance < Response
    option :balance, proc(&:to_f), optional: true
  end
end
