class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.float :amount
      t.string :description
      t.datetime :date
      t.integer :user_id
      t.integer :category_id
      t.integer :account_id

      t.timestamps
    end
  end
end
