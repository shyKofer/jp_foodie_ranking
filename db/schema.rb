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

ActiveRecord::Schema.define(version: 2019_10_24_154647) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "adminpack"
  enable_extension "plpgsql"

  create_table "tabelog_restaurant_infos", force: :cascade do |t|
    t.integer "uri_id"
    t.string "name"
    t.string "genre"
    t.string "nearby_station"
    t.string "distance_from_station"
    t.string "rating"
    t.integer "review_cnt"
    t.string "lunch_budget"
    t.string "dinner_budget"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tabelog_restaurants", force: :cascade do |t|
    t.string "city"
    t.string "prefecture_group_id"
    t.string "prefecture"
    t.string "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tabelog_uris", force: :cascade do |t|
    t.string "prefecture"
    t.string "area_group_uri"
    t.string "area_group_name"
    t.string "area_uri"
    t.string "area_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
