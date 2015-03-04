# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150304104417) do

  create_table "accounts", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.integer  "person_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "accounts", ["person_id"], name: "index_accounts_on_person_id"

  create_table "addresses", force: :cascade do |t|
    t.string   "city"
    t.string   "street"
    t.string   "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cars", force: :cascade do |t|
    t.string   "registration_number"
    t.string   "model"
    t.integer  "owner_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "cars", ["owner_id"], name: "index_cars_on_owner_id"

  create_table "parkings", force: :cascade do |t|
    t.integer "places"
    t.string  "kind"
    t.decimal "hour_price"
    t.decimal "day_price"
    t.integer "address_id"
    t.integer "owner_id"
  end

  add_index "parkings", ["address_id"], name: "index_parkings_on_address_id"
  add_index "parkings", ["owner_id"], name: "index_parkings_on_owner_id"

  create_table "people", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "place_rents", force: :cascade do |t|
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.decimal  "price"
    t.integer  "parking_id"
    t.integer  "car_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  add_index "place_rents", ["car_id"], name: "index_place_rents_on_car_id"
  add_index "place_rents", ["parking_id"], name: "index_place_rents_on_parking_id"
  add_index "place_rents", ["slug"], name: "index_place_rents_on_slug", unique: true

end
