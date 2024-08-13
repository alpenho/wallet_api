class TransactionDeposit < Transaction
  before_validation :set_defaults

  validates :target_wallet, presence: true
  
  private

  def set_defaults
    self.transaction_type = :deposit
  end
end
