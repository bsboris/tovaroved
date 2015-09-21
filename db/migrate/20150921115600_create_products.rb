class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.belongs_to :brand, null: false, index: true, foreign_key: true
      t.belongs_to :category, null: false, index: true, foreign_key: true
      t.string :name, null: false
      t.integer :price_cents, null: false, default: 0
      t.timestamps null: false
    end
  end
end
