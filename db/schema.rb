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

ActiveRecord::Schema.define(version: 20170511171003) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.integer  "course_date_id"
    t.string   "stripe_charge_id"
    t.string   "name"
    t.string   "email"
    t.string   "telephone"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "town"
    t.string   "county"
    t.string   "postcode"
    t.boolean  "paid"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "country"
  end

  add_index "bookings", ["course_date_id"], name: "index_bookings_on_course_date_id", using: :btree

  create_table "course_dates", force: :cascade do |t|
    t.integer  "course_id"
    t.datetime "begins_at"
    t.integer  "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "course_dates", ["course_id"], name: "index_course_dates_on_course_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "qualification",       default: false
    t.string   "level"
    t.boolean  "part_time",           default: false
    t.boolean  "full_time",           default: false
    t.text     "application_process"
    t.text     "progression"
    t.text     "course_content"
    t.string   "external_link"
    t.float    "cost"
    t.string   "duration"
    t.string   "qualification_no"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "slug"
    t.boolean  "show_interest",       default: true
    t.boolean  "pay_by_card",         default: false
    t.boolean  "pay_by_invoice",      default: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.string   "organisation_name"
    t.string   "contact_person"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "town"
    t.string   "county"
    t.string   "postcode"
    t.string   "telephone_no"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_foreign_key "course_dates", "courses"
end
