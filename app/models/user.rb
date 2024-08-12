class User < ApplicationRecord
  has_many :wallets, as: :owner
end
