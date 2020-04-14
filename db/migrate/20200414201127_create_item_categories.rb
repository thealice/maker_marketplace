class CreateItemCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :item_categories do |t|
      t.references :item, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
