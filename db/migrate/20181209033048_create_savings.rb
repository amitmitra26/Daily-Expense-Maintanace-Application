class CreateSavings < ActiveRecord::Migration[5.2]
  def change
    create_table :savings do |t|
      t.string :amount

      t.timestamps
    end
  end
end
