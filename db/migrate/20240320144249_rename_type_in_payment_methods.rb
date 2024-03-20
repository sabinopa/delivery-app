class RenameTypeInPaymentMethods < ActiveRecord::Migration[7.1]
  def change
    rename_column :payment_methods, :type, :method
  end
end
