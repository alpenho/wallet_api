class Wallet < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :outgoing_transactions, class_name: 'Transaction', 
                            foreign_key: 'source_wallet_id'
  has_many :incoming_transactions, class_name: 'Transaction',
                            foreign_key: 'target_wallet_id'

  def balance
    sum_incoming_amount - sum_outgoing_amount
  end

  def deposit!(amount)
    trx = TransactionDeposit.new(amount: amount, target_wallet: self)
    trx.save!
  end

  def withdraw!(amount)
    raise Error('Insufficient amount') if balance < amount

    trx = TransactionWithdraw.new(amount: amount, source_wallet: self)
    trx.save!
  end

  def transfer!(amount, target_wallet)
    raise Error('Insufficient amount') if balance < amount

    trx = TransactionTransfer.new(amount: amount, source_wallet: self, target_wallet: target_wallet)
    trx.save!
  end

  private

  def sum_outgoing_amount
    self.outgoing_transactions.inject(0){ |sum, trx| sum + trx.amount }
  end

  def sum_incoming_amount
    self.incoming_transactions.inject(0){ |sum, trx| sum + trx.amount }
  end
end
