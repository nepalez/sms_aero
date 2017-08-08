class SmsAero
  operation :delete_phone do
    option :phone, Phone
    option :group, FilledString, optional: true

    path  "delphone"
    query { options.select { |key| %i[phone group].include? key } }
  end
end
