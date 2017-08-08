class SmsAero
  class Response::WithStatuses < Response
    option :data, method(:Array), optional: true, as: :statuses
  end
end
