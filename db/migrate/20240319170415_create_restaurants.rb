class CreateRestaurants < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurants do |t|
      t.string :brand_name
      t.string :corporate_name
      t.string :registration_number
      t.string :phone_number
      t.string :email
      t.string :address
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :description
      t.time :estimated_time
      t.string :cancelation_policy
      t.references :payment_method, null: false, foreign_key: true
      t.references :owner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
