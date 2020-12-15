class CreateIncomes < ActiveRecord::Migration[6.0]
  def change
    create_table :incomes do |t|
      t.float :amount
      t.integer :user_id
      
      t.timestamps
    end
  end
end
