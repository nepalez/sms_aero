class SmsAero
  operation :add_blacklist do
    option :phone, Phone

    path  "addblacklist"
    query { { phone: phone } }
  end
end
