class CreateCategoriesTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :categories_transactions, :id => false do |t|
      t.integer :category_id
      t.integer :transaction_id
    end

    add_index :categories_transactions, :category_id
    add_index :categories_transactions, :transaction_id
  end
end
