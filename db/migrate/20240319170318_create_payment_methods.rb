class CreatePaymentMethods < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_methods do |t|
      t.boolean :bank_transfer
      t.boolean :credit_card
      t.boolean :debit_card
      t.boolean :cash

      t.timestamps
    end
  end
end
