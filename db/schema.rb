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

ActiveRecord::Schema.define(version: 20160612191627) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allowed_actions", force: :cascade do |t|
    t.string   "controller"
    t.string   "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "field_definitions", force: :cascade do |t|
    t.integer  "type_id"
    t.string   "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "field_definitions", ["type_id"], name: "index_field_definitions_on_type_id", using: :btree

  create_table "fields", force: :cascade do |t|
    t.integer  "page_id"
    t.integer  "field_definition_id"
    t.string   "value"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "fields", ["field_definition_id"], name: "index_fields_on_field_definition_id", using: :btree
  add_index "fields", ["page_id"], name: "index_fields_on_page_id", using: :btree

  create_table "menu_items", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "menu_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "parent_id"
  end

  add_index "menu_items", ["menu_id"], name: "index_menu_items_on_menu_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "slug"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
    t.integer  "type_id"
  end

  add_index "pages", ["category_id"], name: "index_pages_on_category_id", using: :btree
  add_index "pages", ["type_id"], name: "index_pages_on_type_id", using: :btree

  create_table "role_actions", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "allowed_action_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "role_actions", ["allowed_action_id"], name: "index_role_actions_on_allowed_action_id", using: :btree
  add_index "role_actions", ["role_id"], name: "index_role_actions_on_role_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "field_definitions", "types"
  add_foreign_key "fields", "field_definitions"
  add_foreign_key "fields", "pages"
  add_foreign_key "menu_items", "menus"
  add_foreign_key "pages", "categories"
  add_foreign_key "pages", "types"
  add_foreign_key "role_actions", "allowed_actions"
  add_foreign_key "role_actions", "roles"
  add_foreign_key "user_roles", "users"
end
