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

ActiveRecord::Schema.define(version: 20160716010300) do

  create_table "admins", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "cell",       limit: 255
    t.string   "qq",         limit: 255
    t.text     "desc",       limit: 65535
    t.string   "state",      limit: 255
    t.text     "note",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.string   "url",                limit: 255
    t.string   "image",              limit: 255
    t.integer  "amount",             limit: 4,     default: 0
    t.string   "state",              limit: 255
    t.date     "effective_date"
    t.date     "expire_date"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "quota",              limit: 4,     default: 0
    t.text     "content",            limit: 65535
    t.text     "official_benefit",   limit: 65535
    t.text     "additional_benefit", limit: 65535
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "event_id",   limit: 4
    t.integer  "amount",     limit: 4
    t.string   "state",      limit: 255
    t.date     "date"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "orders", ["event_id"], name: "index_orders_on_event_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "tickets", force: :cascade do |t|
    t.text     "ticket",     limit: 65535
    t.text     "token",      limit: 65535
    t.datetime "expires_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "openid",     limit: 255
    t.string   "name",       limit: 255
    t.string   "gender",     limit: 255
    t.string   "cell",       limit: 255
    t.string   "email",      limit: 255
    t.string   "state",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "orders", "events"
  add_foreign_key "orders", "users"
end
