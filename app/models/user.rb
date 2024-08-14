require 'bcrypt'

class User < ApplicationRecord
  include BCrypt

  has_many :wallets, as: :owner

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  attr_reader :password

  def password=(new_password)
    @password = new_password
    self.salt = BCrypt::Engine.generate_salt
    self.encrypted_password = BCrypt::Engine.hash_secret(new_password, self.salt)
  end

  def authenticate(input_password)
    if BCrypt::Engine.hash_secret(input_password, self.salt) == self.encrypted_password
      self
    else
      false
    end
  end

  # This is to make sure salt and encrypted_password is not shared
  def to_json(options={})
    options[:except] ||= [:salt, :encrypted_password]
    super(options)
  end
end
