class CreateJoinTableExpensesCategories < ActiveRecord::Migration[7.1]
  def change
    create_join_table :expenses, :categories do |t|
      t.index :expense_id
      t.index :category_id
    end 
  end
end
