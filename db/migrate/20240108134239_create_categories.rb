class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.string :name, null: false, index: { unique: true}
      t.string :icon, null: false
      t.timestamps
    end
  end
end
