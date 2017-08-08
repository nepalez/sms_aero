class SmsAero
  operation :add_group do
    option :group, Group

    path  "addgroup"
    query { { group: group } }
  end
end
