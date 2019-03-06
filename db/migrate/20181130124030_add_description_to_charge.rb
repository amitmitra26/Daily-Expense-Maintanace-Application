class AddDescriptionToCharge < ActiveRecord::Migration[5.2]
  def change
    add_column :charges, :description, :string
  end
end
