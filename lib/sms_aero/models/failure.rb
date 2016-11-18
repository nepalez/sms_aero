class SmsAero::Failure < Evil::Client::Model
  attribute :result, default: proc { "rejected" }
  attribute :reason, default: proc { nil }

  def success?
    false
  end
end
