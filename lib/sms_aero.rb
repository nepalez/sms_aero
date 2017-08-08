require "evil/client"

# HTTP(s) client to the "SMS Aero" online service
class SmsAero < Evil::Client
  require_relative "sms_aero/models/callable"
  require_relative "sms_aero/models/optional"
  require_relative "sms_aero/models/filled_string"
  require_relative "sms_aero/models/future"
  require_relative "sms_aero/models/digital"
  require_relative "sms_aero/models/phone"
  require_relative "sms_aero/models/birthday"
  require_relative "sms_aero/models/group"
  require_relative "sms_aero/models/channel"
  require_relative "sms_aero/models/tariff"
  require_relative "sms_aero/response"

  option :user,     FilledString
  option :password, optional: true
  option :token,    default: -> { OpenSSL::Digest::MD5.new.hexdigest(password) }
  option :use_ssl,  true.method(:&), default: proc { true }
  option :use_post, true.method(:&), default: proc { true }
  option :testsend, true.method(:&), default: proc { false }

  path          { "http#{'s' if use_ssl}://gate.smsaero.ru/" }
  http_method   { use_post ? :post : :get }
  query         { { user: user, password: token, answer: "json" } }
  response(200) { |*res| Response.build(*res) }

  require_relative "sms_aero/operations/add_blacklist"
  require_relative "sms_aero/operations/add_group"
  require_relative "sms_aero/operations/add_phone"
  require_relative "sms_aero/operations/check_balance"
  require_relative "sms_aero/operations/check_groups"
  require_relative "sms_aero/operations/check_senders"
  require_relative "sms_aero/operations/check_sending"
  require_relative "sms_aero/operations/check_sign"
  require_relative "sms_aero/operations/check_status"
  require_relative "sms_aero/operations/check_tariff"
  require_relative "sms_aero/operations/delete_group"
  require_relative "sms_aero/operations/delete_phone"
  require_relative "sms_aero/operations/send_sms"
end
