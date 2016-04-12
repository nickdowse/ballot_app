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

ActiveRecord::Schema.define(version: 20150704130415) do

  create_table "candidate_elections", force: :cascade do |t|
    t.integer  "candidate_id"
    t.integer  "election_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "candidates", force: :cascade do |t|
    t.string   "name"
    t.integer  "organisation_id"
    t.text     "description"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "deleted",             default: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "elections", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",      null: false
    t.integer  "created_by"
    t.integer  "organisation_id", null: false
    t.datetime "updated_at",      null: false
    t.text     "description"
    t.datetime "end_date"
  end

  create_table "organisation_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "organisation_id"
    t.string  "role"
  end

  add_index "organisation_users", ["user_id", "organisation_id"], name: "index_organisation_users_on_user_id_and_organisation_id"

  create_table "organisations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "deleted",    default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "votes", force: :cascade do |t|
    t.integer  "value"
    t.integer  "organisation_id"
    t.integer  "election_id"
    t.integer  "user_id"
    t.integer  "candidate_id"
    t.text     "history"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
