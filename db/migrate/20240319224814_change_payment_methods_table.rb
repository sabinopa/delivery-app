class ChangePaymentMethodsTable < ActiveRecord::Migration[7.1]
  def change
    remove_columns :payment_methods, :bank_transfer, :credit_card, :debit_card, :cash
    add_column :payment_methods, :type, :string
  end
end
