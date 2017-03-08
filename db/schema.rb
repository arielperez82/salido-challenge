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

ActiveRecord::Schema.define(version: 20170308070144) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.text     "name",                                null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
  end

  create_table "day_parts", force: :cascade do |t|
    t.integer  "location_id",                          null: false
    t.text     "name",                                 null: false
    t.datetime "created_at",  default: -> { "now()" }, null: false
    t.datetime "updated_at",  default: -> { "now()" }, null: false
    t.index ["location_id"], name: "index_day_parts_on_location_id", using: :btree
  end

  create_table "location_menu_items", force: :cascade do |t|
    t.integer  "location_id",                           null: false
    t.integer  "menu_item_id",                          null: false
    t.datetime "created_at",   default: -> { "now()" }, null: false
    t.datetime "updated_at",   default: -> { "now()" }, null: false
    t.index ["location_id"], name: "index_location_menu_items_on_location_id", using: :btree
    t.index ["menu_item_id"], name: "index_location_menu_items_on_menu_item_id", using: :btree
  end

  create_table "location_price_levels", force: :cascade do |t|
    t.integer  "location_id",                            null: false
    t.integer  "order_type_id",                          null: false
    t.integer  "day_part_id"
    t.datetime "created_at",    default: -> { "now()" }, null: false
    t.datetime "updated_at",    default: -> { "now()" }, null: false
    t.index ["day_part_id"], name: "index_location_price_levels_on_day_part_id", using: :btree
    t.index ["location_id"], name: "index_location_price_levels_on_location_id", using: :btree
    t.index ["order_type_id"], name: "index_location_price_levels_on_order_type_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "brand_id"
    t.text     "name",                                null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index ["brand_id"], name: "index_locations_on_brand_id", using: :btree
  end

  create_table "menu_item_prices", force: :cascade do |t|
    t.integer  "menu_item_id",                                                     null: false
    t.integer  "price_level_id",                                                   null: false
    t.decimal  "price",          precision: 10, scale: 2,                          null: false
    t.datetime "created_at",                              default: -> { "now()" }, null: false
    t.datetime "updated_at",                              default: -> { "now()" }, null: false
    t.index ["menu_item_id"], name: "index_menu_item_prices_on_menu_item_id", using: :btree
    t.index ["price_level_id"], name: "index_menu_item_prices_on_price_level_id", using: :btree
  end

  create_table "menu_items", force: :cascade do |t|
    t.integer  "brand_id"
    t.text     "name",                                null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index ["brand_id"], name: "index_menu_items_on_brand_id", using: :btree
  end

  create_table "order_types", force: :cascade do |t|
    t.integer  "brand_id",                            null: false
    t.text     "name",                                null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index ["brand_id"], name: "index_order_types_on_brand_id", using: :btree
  end

  create_table "price_levels", force: :cascade do |t|
    t.integer  "brand_id",                            null: false
    t.text     "name",                                null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index ["brand_id"], name: "index_price_levels_on_brand_id", using: :btree
  end

  add_foreign_key "day_parts", "locations"
  add_foreign_key "location_menu_items", "locations"
  add_foreign_key "location_menu_items", "menu_items"
  add_foreign_key "location_price_levels", "day_parts"
  add_foreign_key "location_price_levels", "locations"
  add_foreign_key "location_price_levels", "order_types"
  add_foreign_key "locations", "brands"
  add_foreign_key "menu_item_prices", "menu_items"
  add_foreign_key "menu_item_prices", "price_levels"
  add_foreign_key "menu_items", "brands"
  add_foreign_key "order_types", "brands"
  add_foreign_key "price_levels", "brands"
end
