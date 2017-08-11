module SmsAero::Callable
  def call(*args)
    new(*args)
  end
  alias [] call
end
