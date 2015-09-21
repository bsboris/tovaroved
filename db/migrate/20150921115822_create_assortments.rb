class CreateAssortments < ActiveRecord::Migration
  def change
    create_table :assortments do |t|
      t.belongs_to :product, null: false, index: true, foreign_key: true
      t.belongs_to :store, null: false, index: true, foreign_key: true
    end
  end
end
