class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet'
  belongs_to :target_wallet, class_name: 'Wallet'

  enum transaction_type: [ :deposit, :withdraw, :transfer ]

  validates :transaction_type, presence: true
  validates_presence_of :source_wallet, unless: :deposit?
  validates_presence_of :target_wallet, unless: :withdraw?
end
