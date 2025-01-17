class CreateWallets < ActiveRecord::Migration[7.2]
  def change
    create_table :wallets do |t|
      t.string :account_number
      t.references :owner, polymorphic: true, null: false

      t.timestamps
    end
  end
end
