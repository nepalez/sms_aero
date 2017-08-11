class SmsAero
  class Response::WithGroups < Response
    option :reason, method(:Array), as: :channels, optional: true
  end
end
