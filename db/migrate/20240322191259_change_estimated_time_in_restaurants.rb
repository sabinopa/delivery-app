class ChangeEstimatedTimeInRestaurants < ActiveRecord::Migration[7.1]
  def change
    change_column :restaurants, :estimated_time, :integer
  end
end
