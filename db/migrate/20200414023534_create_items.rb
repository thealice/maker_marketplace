class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2, default: 0
      t.integer :quantity
      t.boolean :make_an_offer, default: true
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
