class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.integer :source_wallet_id
      t.integer :target_wallet_id
      t.integer :transaction_type

      t.timestamps
    end

    add_foreign_key :transactions, :wallets, column: :source_wallet_id
    add_foreign_key :transactions, :wallets, column: :target_wallet_id
  end
end
