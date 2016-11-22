require "evil/client"
require "dry-types"

# HTTP(s) client to the "SMS Aero" online service
class SmsAero
  extend Evil::Client::DSL

  # Collection of dry-types with gem-specific additions
  Types = Module.new { |types| types.include Dry::Types.module }

  # Definitions for types, models, and API operations
  %w(types models operations).each do |folder|
    path = File.expand_path("../sms_aero/#{folder}/*.rb", __FILE__)
    Dir[path].each { |file| require(file) }
  end

  settings do
    option :user,     Types::FilledString
    option :password, Types::Password
    option :use_ssl,  Types::Form::Bool, default: proc { true }
    option :use_post, Types::Form::Bool, default: proc { true }
  end

  base_url do |settings|
    "http#{'s' if settings.use_ssl}://gate.smsaero.ru/"
  end

  operation do |settings|
    documentation "https://smsaero.ru/api/description/"

    http_method(settings.use_post ? :post : :get)

    security do
      key_auth :user,     settings.user,     using: :query
      key_auth :password, settings.password, using: :query
      key_auth :answer,   "json",            using: :query
    end

    responses format: :json do
      response :success, 200, model: Answer
      response :failure, 200, model: Answer
    end
  end

  private

  def method_missing(name, *args)
    op = operations[name.to_sym]
    op ? op.call(*args) : super
  end

  def respond_to_missing?(name, *)
    operations.key? name.to_sym
  end
end
