# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_01_09_230103) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id", null: false
    t.index ["company_id"], name: "index_categories_on_company_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone_number", null: false
    t.string "id_number", null: false
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id", null: false
    t.index ["company_id"], name: "index_customers_on_company_id"
  end

  create_table "exports", force: :cascade do |t|
    t.string "status"
    t.string "file_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "key"
    t.hstore "data_filters", default: {}
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_exports_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer "quantity", null: false
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.bigint "sale_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_items_on_product_id"
    t.index ["sale_id"], name: "index_items_on_sale_id"
  end

  create_table "movements", force: :cascade do |t|
    t.integer "mov_type", null: false
    t.integer "mov_sub_type", null: false
    t.integer "quantity", null: false
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.decimal "total", precision: 10, scale: 2
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "item_id"
    t.index ["item_id"], name: "index_movements_on_item_id"
    t.index ["product_id"], name: "index_movements_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "brand", null: false
    t.text "description"
    t.integer "unit", null: false
    t.string "size", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.bigint "user_id", null: false
    t.bigint "provider_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "initial_quantity"
    t.bigint "company_id", null: false
    t.string "picture"
    t.bigint "category_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["company_id"], name: "index_products_on_company_id"
    t.index ["provider_id"], name: "index_products_on_provider_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.text "description"
    t.string "picture"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id", null: false
    t.index ["company_id"], name: "index_providers_on_company_id"
  end

  create_table "sale_prices", force: :cascade do |t|
    t.decimal "price", precision: 10, scale: 2, null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.hstore "transitions", default: [], array: true
    t.index ["product_id"], name: "index_sale_prices_on_product_id"
  end

  create_table "sales", force: :cascade do |t|
    t.decimal "total", precision: 10, scale: 2
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.bigint "client_id", null: false
    t.string "status"
    t.hstore "transitions", default: [], array: true
    t.index ["client_id"], name: "index_sales_on_client_id"
    t.index ["user_id"], name: "index_sales_on_user_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.integer "quantity", null: false
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.decimal "total", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "movement_id", null: false
    t.index ["movement_id"], name: "index_stocks_on_movement_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id", null: false
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "categories", "companies"
  add_foreign_key "customers", "companies"
  add_foreign_key "exports", "users"
  add_foreign_key "items", "products"
  add_foreign_key "items", "sales"
  add_foreign_key "movements", "items"
  add_foreign_key "movements", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "companies"
  add_foreign_key "products", "providers"
  add_foreign_key "products", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "providers", "companies"
  add_foreign_key "sale_prices", "products"
  add_foreign_key "sales", "customers", column: "client_id"
  add_foreign_key "sales", "users"
  add_foreign_key "stocks", "movements"
  add_foreign_key "users", "companies"
end
