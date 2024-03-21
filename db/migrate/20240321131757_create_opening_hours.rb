class CreateOpeningHours < ActiveRecord::Migration[7.1]
  def change
    create_table :opening_hours do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.integer :day_of_week
      t.time :open_time
      t.time :close_time

      t.timestamps
    end
  end
end
