class AddBalanceToWallets < ActiveRecord::Migration[7.2]
  def change
    add_column :wallets, :balance, :integer, null: false, default: 0
  end
end
