class SmsAero
  operation :add_phone do
    documentation "https://smsaero.ru/api/description/#contacts"

    path { "addphone" }

    query do
      attribute :phone, Types::Phone
      attribute :lname, Types::FilledString, optional: true
      attribute :fname, Types::FilledString, optional: true
      attribute :sname, Types::FilledString, optional: true
      attribute :param, Types::FilledString, optional: true
      attribute :bday,  Types::Birthday,     optional: true
    end
  end
end
