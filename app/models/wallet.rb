class Wallet < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :outgoing_transactions, class_name: 'Transaction', 
                            foreign_key: 'source_wallet_id'
  has_many :incoming_transactions, class_name: 'Transaction',
                            foreign_key: 'target_wallet_id'
end
