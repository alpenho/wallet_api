class Transaction < ApplicationRecord
  belongs_to :source_wallet_id, class_name: 'Wallet'
  belongs_to :target_wallet_id, class_name: 'Wallet'
end
