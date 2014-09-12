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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140514191313) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.text     "info"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "team_id"
  end

  create_table "histories", :force => true do |t|
    t.integer  "schedule_id"
    t.datetime "completed_for"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_id"
  end

  create_table "schedules", :force => true do |t|
    t.string   "kind",              :default => "none"
    t.integer  "weekly_day"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "task_id"
    t.date     "yearly_date"
    t.integer  "monthly_day"
    t.date     "once_date"
    t.date     "weekly_date"
    t.integer  "weekly_interval"
    t.integer  "status_id"
    t.integer  "few_months_recur"
    t.integer  "few_months_day"
    t.boolean  "certain_monday"
    t.boolean  "certain_tuesday"
    t.boolean  "certain_wednesday"
    t.boolean  "certain_thursday"
    t.boolean  "certain_friday"
    t.boolean  "certain_saturday"
    t.boolean  "certain_sunday"
  end

  create_table "statuses", :force => true do |t|
    t.string   "title"
    t.text     "info"
    t.integer  "task_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "tasks", :force => true do |t|
    t.integer  "company_id"
    t.text     "info"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "title"
    t.integer  "user_id"
    t.integer  "category_id"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "failed_attempts"
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.boolean  "admin",                  :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
