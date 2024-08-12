class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.references :source_wallet_id, null: false
      t.references :target_wallet_id, null: false
      t.integer :transaction_type

      t.timestamps
    end

    add_foreign_key :transactions, :wallets, column: :source_wallet_id
    add_foreign_key :transactions, :wallets, column: :target_wallet_id
  end
end
