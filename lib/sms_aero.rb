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

  operation :add_blacklist do
    option :phone, Phone

    path  "addblacklist"
    query { { phone: phone } }
  end

  operation :add_group do
    option :group, Group

    path  "addgroup"
    query { { group: group } }
  end

  operation :add_phone do
    option :phone,  Phone
    option :group,  optional: true, type: Group
    option :bday,   optional: true, type: Birthday
    option :lname,  optional: true
    option :fname,  optional: true
    option :sname,  optional: true
    option :param,  optional: true
    option :param2, optional: true
    option :param3, optional: true

    path  "addphone"
    query { options.except :password, :token, :use_ssl, :use_post, :testsend }
  end

  operation :check_balance do
    path "balance"
    response(200) { |*res| Response::WithBalance.build(*res) }
  end

  operation :check_groups do
    path "checkgroup"
    response(200) { |*res| Response::WithGroups.build(*res) }
  end

  operation :check_senders do
    option :sign, FilledString

    path          "senders"
    query         { { sign: sign } }
    response(200) { |*res| Response::WithSenders.build(*res) }
  end

  require_relative "sms_aero/operations/check_sending"
  require_relative "sms_aero/operations/check_sign"
  require_relative "sms_aero/operations/check_status"
  require_relative "sms_aero/operations/check_tariff"
  require_relative "sms_aero/operations/delete_group"
  require_relative "sms_aero/operations/delete_phone"
  require_relative "sms_aero/operations/send_sms"
end
