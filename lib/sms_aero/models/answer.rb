class SmsAero
  class Answer < Evil::Struct
    attribute :reason, default: proc { nil }
    attribute :result,
              Types::FilledString.constructor(&:strip),
              default: proc { "accepted" }
  end
end
