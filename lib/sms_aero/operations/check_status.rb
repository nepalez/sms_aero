class SmsAero
  operation :check_status do
    option :id, FilledString

    path  "status"
    query { { id: id } }
  end
end
