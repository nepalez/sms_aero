module SmsAero::Types
  Password = \
    Strict::String.constructor do |value|
      OpenSSL::Digest::MD5.new.hexdigest(value)
    end
end
