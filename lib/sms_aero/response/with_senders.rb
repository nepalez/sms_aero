class SmsAero
  class Response::WithSenders < Response
    option :data, method(:Array), optional: true, as: :senders
  end
end
