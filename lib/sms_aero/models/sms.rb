# Describes an SMS that can be send to either a phone or a group
class SmsAero
  class Sms < Evil::Struct
    attribute :text,    Types::FilledString
    attribute :date,    Types::Future,  optional: true
    attribute :digital, Types::Digital, optional: true
    attribute :type,    Types::Channel, default: -> (*) do
                                                   if digital == 1
                                                     Dry::Initializer::UNDEFINED
                                                   else
                                                     2
                                                   end
                                                 end
  end
end
