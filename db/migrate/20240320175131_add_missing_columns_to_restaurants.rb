class AddMissingColumnsToRestaurants < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :vegan_options, :boolean
    add_column :restaurants, :vegetarian_options, :boolean
    add_column :restaurants, :gluten_free_options, :boolean
  end
end
