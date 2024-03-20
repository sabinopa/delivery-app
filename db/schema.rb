ActiveRecord::Schema[7.1].define(version: 2024_03_20_144249) do
  create_table "owners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "lastname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_owners_on_reset_password_token", unique: true
  end

  create_table "payment_methods", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "method"
  end

  create_table "payment_methods_restaurants", id: false, force: :cascade do |t|
    t.integer "restaurant_id", null: false
    t.integer "payment_method_id", null: false
    t.index ["payment_method_id", "restaurant_id"], name: "idx_on_payment_method_id_restaurant_id_75681689bc"
    t.index ["restaurant_id", "payment_method_id"], name: "idx_on_restaurant_id_payment_method_id_33eff2fee9"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "brand_name"
    t.string "corporate_name"
    t.string "registration_number"
    t.string "phone_number"
    t.string "email"
    t.string "address"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "description"
    t.time "estimated_time"
    t.string "cancelation_policy"
    t.integer "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_restaurants_on_owner_id"
  end

  add_foreign_key "restaurants", "owners"
end
