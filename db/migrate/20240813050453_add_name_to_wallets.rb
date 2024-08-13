class AddNameToWallets < ActiveRecord::Migration[7.2]
  def change
    add_column :wallets, :name, :string
  end
end
