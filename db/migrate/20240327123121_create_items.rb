class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :price
      t.references :category, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true
      t.integer :spice_level
      t.string :additional
      t.boolean :vegan
      t.boolean :vegetarian
      t.boolean :gluten_free

      t.timestamps
    end
  end
end
