class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.decimal :amount, precision: 18, scale: 2
      t.text :description
      t.references :creator
      t.references :expense

      t.timestamps
    end
  end
end
