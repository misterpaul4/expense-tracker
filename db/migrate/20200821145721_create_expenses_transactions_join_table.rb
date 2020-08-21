class CreateExpensesTransactionsJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses_transactions, id: false do |t|
      t.bigint :expense_id
      t.bigint :transaction_id
    end

    add_index :expenses_transactions, :expense_id
    add_index :expenses_transactions, :transaction_id
  end
end
