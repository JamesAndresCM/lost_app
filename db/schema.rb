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

ActiveRecord::Schema.define(version: 2018_12_15_195813) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.bigint "user_id"
    t.text "content", null: false
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.bigint "province_id"
    t.index ["name"], name: "index_districts_on_name"
    t.index ["province_id"], name: "index_districts_on_province_id"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "district_id"
    t.string "title"
    t.string "description"
    t.string "img"
    t.integer "status"
    t.datetime "datetime_lost"
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "type_post"
    t.index ["category"], name: "index_posts_on_category"
    t.index ["district_id"], name: "index_posts_on_district_id"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
    t.index ["status"], name: "index_posts_on_status"
    t.index ["title"], name: "index_posts_on_title"
    t.index ["type_post"], name: "index_posts_on_type_post"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "provinces", force: :cascade do |t|
    t.string "name"
    t.bigint "region_id"
    t.index ["name"], name: "index_provinces_on_name"
    t.index ["region_id"], name: "index_provinces_on_region_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.string "iso_code"
    t.string "region_number"
    t.index ["name"], name: "index_regions_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.string "uid"
    t.string "provider"
    t.string "username"
    t.string "slug"
    t.integer "role", default: 0
    t.string "avatar"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "comments", "users"
  add_foreign_key "districts", "provinces"
  add_foreign_key "posts", "districts"
  add_foreign_key "posts", "users"
  add_foreign_key "provinces", "regions"
end
