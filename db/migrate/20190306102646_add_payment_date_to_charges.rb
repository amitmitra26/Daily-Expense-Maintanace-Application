class AddPaymentDateToCharges < ActiveRecord::Migration[5.2]
  def change
    add_column :charges, :payment_date, :date
  end
end
