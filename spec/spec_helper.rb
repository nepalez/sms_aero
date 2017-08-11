begin
  require "pry"
rescue LoadError
  nil
end

require "sms_aero"
require "webmock/rspec"

RSpec.configure do |config|
  config.order = :random
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.around(:each) do |example|
    stub_request(:any, //)
    example.run
  end
end

I18n.available_locales = %i[en]
I18n.locale = :en
I18n.load_path = %w[spec/support/en.yml]
