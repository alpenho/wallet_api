class TransactionWithdraw < Transaction
  before_validation :set_defaults

  validates :source_wallet, presence: true
  
  private

  def set_defaults
    self.transaction_type = :withdraw
  end
end
