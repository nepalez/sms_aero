require "evil/client"
require "dry-types"

# HTTP(s) client to the "SMS Aero" online service
class SmsAero
  extend Evil::Client::DSL

  # Collection of dry-types with gem-specific additions
  Types = Module.new { |types| types.include Dry::Types.module }

  require_relative "sms_aero/types/birthday"
  require_relative "sms_aero/types/channel"
  require_relative "sms_aero/types/digital"
  require_relative "sms_aero/types/future"
  require_relative "sms_aero/types/phone"
  require_relative "sms_aero/types/sign_status"

  require_relative "sms_aero/models/answer"

  require_relative "sms_aero/operations/add_blacklist"

  settings do
    option :user,     Types::Strict::String
    option :password, Types::Strict::String
    option :use_ssl,  Types::Form::Bool, default: proc { true }
    option :use_post, Types::Form::Bool, default: proc { true }
  end

  base_url do |settings|
    "http#{"s" if settings.use_ssl}://gate.smsaero.ru/"
  end

  operation do |settings|
    documentation "https://smsaero.ru/api/description/"

    http_method(settings.use_post ? :post : :get)

    security do |user: nil, password: nil, **|
      key_auth :user,     user     || settings.user,     using: :query
      key_auth :password, password || settings.password, using: :query
      key_auth :answer,   "json",                        using: :query
    end

    responses format: :json do
      response :success, 200, model: Answer
      response :failure, 200, model: Answer
    end
  end
end
