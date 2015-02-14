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

ActiveRecord::Schema.define(version: 20150130062707) do

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "messages", force: true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "content"
    t.boolean  "read_state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["read_state"], name: "index_messages_on_read_state"
  add_index "messages", ["receiver_id"], name: "index_messages_on_receiver_id"

  create_table "relationships", force: true do |t|
    t.integer  "favorer_id"
    t.integer  "favored_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["favored_id"], name: "index_relationships_on_favored_id"
  add_index "relationships", ["favorer_id", "favored_id"], name: "index_relationships_on_favorer_id_and_favored_id", unique: true
  add_index "relationships", ["favorer_id"], name: "index_relationships_on_favorer_id"

  create_table "smiles", force: true do |t|
    t.string   "image"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "smiles", ["image"], name: "index_smiles_on_image", unique: true
  add_index "smiles", ["user_id", "created_at"], name: "index_smiles_on_user_id_and_created_at"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "gender"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.string   "avatar"
    t.string   "introduction"
    t.string   "slug"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["name"], name: "index_users_on_name", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"
  add_index "users", ["slug"], name: "index_users_on_slug"

end
