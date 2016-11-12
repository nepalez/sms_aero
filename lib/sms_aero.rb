require "evil/client"
require "dry-types"

# HTTP(s) client to the "SMS Aero" online service
class SmsAero
  extend Evil::Client::DSL

  # Collection of dry-types with gem-specific additions
  Types = Module.new { |types| types.include Dry::Types.module }

  require_relative "sms_aero/types/birthday.rb"
  require_relative "sms_aero/types/channel.rb"
  require_relative "sms_aero/types/digital.rb"
  require_relative "sms_aero/types/future.rb"
  require_relative "sms_aero/types/phone.rb"

  settings do
    using type: Types::Strict::String do
      option :user
      option :password
    end

    using type: Types::Form::Bool, default: -> { true } do
      option :use_ssl,  default: -> { true }
      option :use_post, default: -> { true }
    end
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

    operation 200, 201 do |body:, **|
      Hashie::Mash.new JSON.parse(body)
    end
  end
end
