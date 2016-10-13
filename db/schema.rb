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

ActiveRecord::Schema.define(version: 20161013182300) do

  create_table "cloud_components", force: :cascade do |t|
    t.string   "type"
    t.text     "config"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_cloud_components_on_product_id"
  end

  create_table "cloud_configs", force: :cascade do |t|
    t.string   "actable_type"
    t.integer  "actable_id"
    t.integer  "product_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["actable_type", "actable_id"], name: "index_cloud_configs_on_actable_type_and_actable_id"
    t.index ["product_id"], name: "index_cloud_configs_on_product_id"
  end

  create_table "cloud_instances", force: :cascade do |t|
    t.string   "type"
    t.string   "name"
    t.text     "init_config"
    t.integer  "environment_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["environment_id"], name: "index_cloud_instances_on_environment_id"
  end

  create_table "environments", force: :cascade do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "approved"
    t.text     "description"
    t.integer  "product_id"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["product_id"], name: "index_environments_on_product_id"
    t.index ["project_id"], name: "index_environments_on_project_id"
  end

  create_table "oraclecloud_database_configs", force: :cascade do |t|
    t.string   "service_name"
    t.integer  "edition"
    t.string   "ssh_key"
    t.integer  "shape"
    t.string   "version"
    t.integer  "level"
    t.integer  "subscription_type"
    t.string   "description"
    t.integer  "product_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["product_id"], name: "index_oraclecloud_database_configs_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.float    "budget"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rate_cards", force: :cascade do |t|
    t.string   "provider"
    t.string   "key"
    t.float    "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
