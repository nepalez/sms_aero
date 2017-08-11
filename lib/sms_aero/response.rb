class SmsAero::Response
  extend Dry::Initializer
  extend SmsAero::Optional
  option :reason, proc(&:to_s),    default: proc { nil }
  option :result, proc(&:strip),   default: -> { "accepted" }

  def success?
    result == "accepted"
  end

  class << self
    def build(*res)
      body = res.last
      new JSON.parse(body.first)
    end

    def new(opts)
      super \
        opts.each_with_object({}) { |(key, val), obj| obj[key.to_sym] = val }
    end
  end

  # Operation-specific responses
  require_relative "response/with_balance"
  require_relative "response/with_groups"
  require_relative "response/with_id"
  require_relative "response/with_senders"
  require_relative "response/with_statuses"
  require_relative "response/with_tariff"
end
