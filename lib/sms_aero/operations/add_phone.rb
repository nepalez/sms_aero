class SmsAero
  operation :add_phone do
    option :phone,  Phone
    option :group,  Group,        optional: true
    option :lname,  proc(&:to_s), optional: true
    option :fname,  proc(&:to_s), optional: true
    option :sname,  proc(&:to_s), optional: true
    option :param,  proc(&:to_s), optional: true
    option :param2, proc(&:to_s), optional: true
    option :param3, proc(&:to_s), optional: true
    option :bday,   Birthday,     optional: true

    path  "addphone"
    query { options.except :password, :token, :use_ssl, :use_post, :testsend }
  end
end
