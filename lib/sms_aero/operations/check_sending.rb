class SmsAero
  operation :check_sending do
    option :id, FilledString

    path  "checksending"
    query { { id: id } }
  end
end
