module SmsAero::Optional
  private

  def initialize(opts)
    super opts.each_with_object({}) { |(key, val), obj| obj[key.to_sym] = val }
  end

  def respond_to_missing?(name, *)
    @__options__.respond_to? name
  end

  def method_missing(*args, &block)
    respond_to_missing?(*args) ? @__options__.send(*args, &block) : super
  end
end
