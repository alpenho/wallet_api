class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  enum :transaction_type, [ :deposit, :withdraw, :transfer ]

  validates :transaction_type, presence: true
end
