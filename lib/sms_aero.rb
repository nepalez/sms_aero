require "evil/client"
require "dry-types"

# HTTP(s) client to the "SMS Aero" online service
class SmsAero
  extend Evil::Client::DSL

  # Collection of dry-types with gem-specific additions
  Types = Module.new { |types| types.include Dry::Types.module }

  %w(types operations scopes).each do |folder|
    Dir["sms_aero/#{folder}"].each { |file| require_relative file }
  end
end
