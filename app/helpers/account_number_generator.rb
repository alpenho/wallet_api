module AccountNumberGenerator
  USER_WALLET_PREFIX = '999'

  def self.generate(model_object)
    prefix = USER_WALLET_PREFIX if model_object.class.name == 'User'
    "#{prefix}#{model_object.id}#{Time.now.to_time.to_i}"
  end
end