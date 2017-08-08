class SmsAero
  operation :delete_group do
    option :group, FilledString

    path  "delgroup"
    query { options.select { |key| key == :group } }
  end
end
