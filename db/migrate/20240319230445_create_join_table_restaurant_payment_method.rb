class CreateJoinTableRestaurantPaymentMethod < ActiveRecord::Migration[7.1]
  def change
    create_join_table :restaurants, :payment_methods do |t|
      t.index [:restaurant_id, :payment_method_id]
      t.index [:payment_method_id, :restaurant_id]
    end
  end
end
