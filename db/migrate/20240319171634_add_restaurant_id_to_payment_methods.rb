class AddRestaurantIdToPaymentMethods < ActiveRecord::Migration[7.1]
  def change
    add_column :payment_methods, :restaurant_id, :integer
    add_index :payment_methods, :restaurant_id
  end
end
