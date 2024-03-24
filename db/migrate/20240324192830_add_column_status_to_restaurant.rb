class AddColumnStatusToRestaurant < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :status, :integer, default: 0
  end
end
