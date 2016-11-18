class SmsAero::Success < Evil::Client::Model
  attribute :result, default: proc { "accepted" }
  attribute :reason, default: proc { nil }

  def success?
    true
  end
end
