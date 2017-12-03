require "evil/client"

I18n.load_path += [File.expand_path("../../config/locales/en.yml", __FILE__)]

# HTTP(s) client to the "SMS Aero" online service
class SmsAero < Evil::Client
  require_relative "sms_aero/callable"
  require_relative "sms_aero/optional"
  require_relative "sms_aero/filled_string"
  require_relative "sms_aero/future"
  require_relative "sms_aero/digital"
  require_relative "sms_aero/phone"
  require_relative "sms_aero/birthday"
  require_relative "sms_aero/group"
  require_relative "sms_aero/channel"
  require_relative "sms_aero/tariff"
  require_relative "sms_aero/hlr_status"
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
  headers "X-Ruby-Client"    => "https://github.com/nepalez/sms_aero",
          "X-Ruby-Framework" => "https://github.com/evilmartians/evil-client"

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

  operation :check_sending do
    option :id, FilledString

    path  "checksending"
    query { { id: id } }
  end

  operation :check_sign do
    option :sign, FilledString

    path  "sign"
    query { { sign: sign } }

    response(200) do |_, _, body|
      data = JSON.parse(body.first)
      Response::WithStatuses.new(data: data)
    end
  end

  operation :check_status do
    option :id, FilledString

    path  "status"
    query { { id: id } }
  end

  operation :check_tariff do
    path "checktarif"

    response(200) { |*res| Response::WithTariff.build(*res) }
  end

  operation :delete_group do
    option :group, FilledString

    path  "delgroup"
    query { { group: group } }
  end

  operation :delete_phone do
    option :phone, Phone
    option :group, FilledString, optional: true

    path  "delphone"
    query { options.slice(:phone, :group) }
  end

  operation :send_sms do
    option :to,      Phone, optional: true
    option :group,   Group, optional: true
    option :from,    FilledString
    option :text,    FilledString
    option :date,    Future,  optional: true
    option :digital, Digital, optional: true
    option :type,    Channel, default: -> { 2 unless digital == 1 }

    validate { errors.add :missed_address unless !to ^ !group }

    path  { group && "sendtogroup" || testsend && "testsend" || "send" }
    query { options.slice(:to, :group, :from, :text, :date, :digital, :type) }

    response(200) { |*res| Response::WithId.build(*res) }
  end

  operation :hlr do
    option :phone, Phone

    path  "hlr"
    query { { phone: phone } }

    response(200) { |*res| Response::WithId.build(*res) }
  end

  operation :hlr_status do
    option :id, FilledString

    path  "hlrStatus"
    query { { id: id } }

    response(200) { |*res| Response::WithHlr.build(*res) }
  end
end
