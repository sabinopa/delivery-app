class RemovePaymentMethodIdFromRestaurants < ActiveRecord::Migration[7.1]
  def change
    remove_column :restaurants, :payment_method_id, :integer
  end
end
