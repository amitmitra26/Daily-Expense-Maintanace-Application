class AddAmountToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :amount, :string
  end
end
