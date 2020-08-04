class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions, &:timestamps
  end
end
