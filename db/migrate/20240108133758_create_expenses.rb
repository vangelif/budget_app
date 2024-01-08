class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses do |t|
      t.references :user, null: false, foreign_key: { to_table: :users }, index: true
      t.string :name, null: false
      t.decimal :amount, null: false

      t.timestamps
    end
  end
end
