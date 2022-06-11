# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_06_11_091637) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "cube"
  enable_extension "earthdistance"
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.string "address"
    t.datetime "time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "lng", precision: 10, scale: 6
    t.bigint "seller_id"
    t.bigint "realtor_id"
    t.index "ll_to_earth((lat)::double precision, (lng)::double precision)", name: "appointments_earthdistance_ix", using: :gist
    t.index ["realtor_id"], name: "index_appointments_on_realtor_id"
    t.index ["seller_id"], name: "index_appointments_on_seller_id"
  end

  create_table "realtors", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "lng", precision: 10, scale: 6
    t.index "ll_to_earth((lat)::double precision, (lng)::double precision)", name: "realtors_earthdistance_ix", using: :gist
  end

  create_table "sellers", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "appointments", "realtors"
  add_foreign_key "appointments", "sellers"
end
