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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: true do |t|
    t.string  "country_code",      limit: 200
    t.integer "panel_provider_id"
  end

  create_table "country_target_groups", force: true do |t|
    t.integer "country_id"
    t.integer "target_group_id"
  end

  create_table "location_groups", force: true do |t|
    t.string  "name",              limit: 200
    t.integer "country_id"
    t.integer "panel_provider_id"
  end

  create_table "location_location_groups", force: true do |t|
    t.integer "location_id"
    t.integer "location_group_id"
  end

  create_table "locations", force: true do |t|
    t.string  "name",        limit: 200
    t.integer "external_id"
    t.string  "secret_code", limit: 200
  end

  create_table "panel_providers", force: true do |t|
    t.string "code", limit: 200
  end

  create_table "target_groups", force: true do |t|
    t.string  "name",              limit: 200
    t.integer "external_id"
    t.integer "parent_id"
    t.integer "panel_provider_id"
    t.string  "secret_code",       limit: 200
  end

  create_table "users", force: true do |t|
    t.string   "username",        limit: 200
    t.string   "email",           limit: 200
    t.datetime "created_at"
    t.datetime "update_at"
    t.string   "hashed_password", limit: 200
  end


  create_table "cities", force: true do |t|
    t.string  "name",        limit: 200
    t.integer "country_id"
  end

end
