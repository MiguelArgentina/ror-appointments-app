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

ActiveRecord::Schema[7.0].define(version: 2022_09_12_021108) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "booking_types", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "cost_id", null: false
    t.integer "duration"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cost_id"], name: "index_booking_types_on_cost_id"
    t.index ["user_id"], name: "index_booking_types_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.decimal "amount"
    t.string "code"
    t.datetime "start_time"
    t.boolean "owes_payment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "booking_type_id", null: false
    t.bigint "user_id", null: false
    t.bigint "provider_id", null: false
    t.index ["booking_type_id"], name: "index_bookings_on_booking_type_id"
    t.index ["provider_id"], name: "index_bookings_on_provider_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "costs", force: :cascade do |t|
    t.datetime "start_date"
    t.decimal "amount"
    t.integer "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_costs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_type", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "booking_types", "costs"
  add_foreign_key "booking_types", "users"
  add_foreign_key "bookings", "booking_types"
  add_foreign_key "bookings", "users"
  add_foreign_key "bookings", "users", column: "provider_id"
  add_foreign_key "costs", "users"
end
