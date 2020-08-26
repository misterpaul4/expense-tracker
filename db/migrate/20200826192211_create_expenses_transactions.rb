class CreateExpensesTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses_transactions, :id => false do |t|
      t.integer :expense_id
      t.integer :transaction_id
    end
  end
end
