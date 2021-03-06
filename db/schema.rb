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

ActiveRecord::Schema.define(version: 20141024220140) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: true do |t|
    t.string "name", null: false
  end

  create_table "order_item_locations", force: true do |t|
    t.integer "order_item_id"
    t.integer "location_id"
  end

  create_table "order_items", force: true do |t|
    t.string  "name",                             null: false
    t.integer "frequency",      default: 0
    t.string  "frequency_type", default: "month"
    t.date    "last_purchase"
  end

end
