class SmsAero
  operation :send_sms do
    option :to,      Phone, optional: true
    option :group,   Group, optional: true
    option :from,    FilledString
    option :text,    FilledString
    option :date,    Future,  optional: true
    option :digital, Digital, optional: true
    option :type,    Channel, default: -> { 2 unless digital == 1 }

    validate(:address_given) { !to ^ !group }

    path  { group && "sendtogroup" || testsend && "testsend" || "send" }
    query { options.slice(:to, :group, :from, :text, :date, :digital, :type) }

    response(200) { |*res| Response::WithId.build(*res) }
  end
end
