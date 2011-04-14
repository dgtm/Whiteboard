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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110414042604) do

  create_table "ckeditor_assets", :force => true do |t|
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "filename",       :limit => 80
    t.string   "thumbnail",      :limit => 20
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.string   "type",           :limit => 40
    t.integer  "user_id"
    t.integer  "assetable_id"
    t.string   "assetable_type", :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_id", "assetable_type", "type"], :name => "ndx_type_assetable"
  add_index "ckeditor_assets", ["assetable_id", "assetable_type"], :name => "fk_assets"
  add_index "ckeditor_assets", ["parent_id", "type"], :name => "ndx_type_name"
  add_index "ckeditor_assets", ["thumbnail", "parent_id"], :name => "assets_thumbnail_parent_id"
  add_index "ckeditor_assets", ["user_id", "assetable_type", "assetable_id"], :name => "assets_user_type_assetable_id"
  add_index "ckeditor_assets", ["user_id"], :name => "fk_user"

  create_table "documents", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.boolean  "shared"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statistics", :force => true do |t|
    t.integer  "user_id"
    t.integer  "document_id"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.integer  "number"
    t.integer  "user_id"
    t.integer  "document_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
