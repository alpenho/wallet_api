class Wallet < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :outgoing_transactions, class_name: 'Transaction', 
                            foreign_key: 'source_wallet_id'
  has_many :incoming_transactions, class_name: 'Transaction',
                            foreign_key: 'target_wallet_id'
  
  validates :name, presence: true

  def deposit!(amount)
    ActiveRecord::Base.transaction do
      # Lock the wallet row for this user to prevent other operations
      wallet = Wallet.where(id: self.id).lock(true).first
      trx = TransactionDeposit.new(amount: amount, target_wallet: wallet)

      trx.save!
      wallet.update!(balance: wallet.balance + amount) # Update balance
    end
  end

  def withdraw!(amount)
    ActiveRecord::Base.transaction do
      # Lock the wallet row for this user to prevent other operations
      wallet = Wallet.where(id: self.id).lock(true).first
      trx = TransactionWithdraw.new(amount: amount, source_wallet: wallet)

      raise 'Insufficient amount' if wallet.balance < amount

      trx.save!
      wallet.update!(balance: wallet.balance - amount) # Update balance
    end
  end

  def transfer!(amount, target_wallet_id)
    ActiveRecord::Base.transaction do
      # Lock the wallet row for this user to prevent other operations
      target_wallet = Wallet.where(id: target_wallet_id).lock(true).first
      wallet = Wallet.where(id: self.id).lock(true).first
      trx = TransactionTransfer.new(amount: amount, source_wallet: wallet, target_wallet: target_wallet)

      raise 'Target wallet not found' if target_wallet.blank?
      raise 'Insufficient amount' if wallet.balance < amount

      trx.save!
      wallet.update!(balance: wallet.balance - amount) # Update balance
      target_wallet.update!(balance: target_wallet.balance + amount) # Update target wallet balance
    end
  end
end
