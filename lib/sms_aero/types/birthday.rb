module SmsAero::Types
  # Describes a user's birthday in year-month-date format
  # Accepts dates, times, datetimes, and strings parceable to dates
  #
  # @example
  #   SmsAero::Types::Birthday["1901-12-9"]                   # => "1901-12-09"
  #   SmsAero::Types::Birthday[Time.new(1901, 12, 9, 10, 12)] # => "1901-12-09"
  #
  Birthday = Strict::String
             .constrained(format: /\A\d{4}-\d{2}-\d{2}\z/)
             .constructor do |value|
               begin
                 date = value.to_date if value.respond_to? :to_date
                 date ||= ::Date.parse(value.to_s)
                 date.strftime "%Y-%m-%d"
               rescue => error
                 raise TypeError, "#{value.inspect} cannot be coerced to date"
               end
             end
end
