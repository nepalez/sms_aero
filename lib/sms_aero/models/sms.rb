# Describes an SMS that can be send to either a phone or a group
class SmsAero
  class Sms < Evil::Client::Model
    attribute :text,    Types::FilledString
    attribute :date,    Types::Future,  optional: true
    attribute :digital, Types::Digital, optional: true
    attribute :type,    Types::Channel, default: -> (*) do
                                          case digital
                                          when Dry::Initializer::UNDEFINED then 2
                                          else Dry::Initializer::UNDEFINED
                                          end
                                        end
  end
end
