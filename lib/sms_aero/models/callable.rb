module SmsAero::Callable
  def call(*args)
    new(*args)
  end
  alias_method :[], :call
end
