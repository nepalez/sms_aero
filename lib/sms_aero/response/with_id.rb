class SmsAero
  class Response::WithId < Response
    option :id, proc(&:to_s), optional: true

    def success?
      id.to_s != ""
    end
  end
end
