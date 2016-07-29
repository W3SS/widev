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

ActiveRecord::Schema.define(version: 20160729085606) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "installation_id"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

  create_table "attachments", force: :cascade do |t|
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "commontator_comments", force: :cascade do |t|
    t.string   "creator_type"
    t.integer  "creator_id"
    t.string   "editor_type"
    t.integer  "editor_id"
    t.integer  "thread_id",                     null: false
    t.text     "body",                          null: false
    t.datetime "deleted_at"
    t.integer  "cached_votes_up",   default: 0
    t.integer  "cached_votes_down", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_comments", ["cached_votes_down"], name: "index_commontator_comments_on_cached_votes_down"
  add_index "commontator_comments", ["cached_votes_up"], name: "index_commontator_comments_on_cached_votes_up"
  add_index "commontator_comments", ["creator_id", "creator_type", "thread_id"], name: "index_commontator_comments_on_c_id_and_c_type_and_t_id"
  add_index "commontator_comments", ["thread_id", "created_at"], name: "index_commontator_comments_on_thread_id_and_created_at"

  create_table "commontator_subscriptions", force: :cascade do |t|
    t.string   "subscriber_type", null: false
    t.integer  "subscriber_id",   null: false
    t.integer  "thread_id",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_subscriptions", ["subscriber_id", "subscriber_type", "thread_id"], name: "index_commontator_subscriptions_on_s_id_and_s_type_and_t_id", unique: true
  add_index "commontator_subscriptions", ["thread_id"], name: "index_commontator_subscriptions_on_thread_id"

  create_table "commontator_threads", force: :cascade do |t|
    t.string   "commontable_type"
    t.integer  "commontable_id"
    t.datetime "closed_at"
    t.string   "closer_type"
    t.integer  "closer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_threads", ["commontable_id", "commontable_type"], name: "index_commontator_threads_on_c_id_and_c_type", unique: true

  create_table "environments", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "installations", force: :cascade do |t|
    t.string   "release"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "rel_template_id"
    t.integer  "environment_id"
    t.boolean  "is_started"
    t.boolean  "is_done"
  end

  create_table "item_per_installations", force: :cascade do |t|
    t.integer  "rel_template_item_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "installation_id"
    t.boolean  "is_done"
    t.boolean  "is_started"
    t.boolean  "is_error"
    t.text     "note"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "item_per_templates", force: :cascade do |t|
    t.integer  "rel_template_id"
    t.integer  "rel_template_item_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "item_per_templates", ["rel_template_id"], name: "index_item_per_templates_on_rel_template_id"
  add_index "item_per_templates", ["rel_template_item_id"], name: "index_item_per_templates_on_rel_template_item_id"

  create_table "queries", force: :cascade do |t|
    t.string   "title"
    t.text     "statment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rel_template_items", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.text     "note"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "rel_templates", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "release_items", force: :cascade do |t|
    t.string   "name"
    t.string   "ftype"
    t.boolean  "scratchable"
    t.boolean  "remove"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "file_name"
    t.integer  "release_id"
  end

  create_table "releases", force: :cascade do |t|
    t.string   "rel"
    t.text     "note"
    t.text     "outcome"
    t.datetime "date"
    t.boolean  "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "system_id"
    t.integer  "reltype_id"
  end

  create_table "reltypes", force: :cascade do |t|
    t.string   "name"
    t.string   "color"
    t.string   "short"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "systems", force: :cascade do |t|
    t.string   "name"
    t.string   "color"
    t.string   "short"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "uploads", force: :cascade do |t|
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "myfile_file_name"
    t.string   "myfile_content_type"
    t.integer  "myfile_file_size"
    t.datetime "myfile_updated_at"
    t.integer  "release_id"
  end

  add_index "uploads", ["release_id"], name: "index_uploads_on_release_id"

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "webservices", force: :cascade do |t|
    t.string   "name"
    t.string   "int_endpoint"
    t.string   "bs"
    t.string   "bs_method"
    t.string   "applet"
    t.string   "applet_method"
    t.text     "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
