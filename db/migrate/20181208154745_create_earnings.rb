class CreateEarnings < ActiveRecord::Migration[5.2]
  def change
    create_table :earnings do |t|
      t.string :amount
      t.string :desc

      t.timestamps
    end
  end
end
