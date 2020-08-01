class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :currency
      t.decimal :budget, precision: 18, scale: 2

      t.timestamps
    end
  end
end
