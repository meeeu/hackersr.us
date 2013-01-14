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

ActiveRecord::Schema.define(:version => 20111207064227) do

  create_table "node_user_relationships", :force => true do |t|
    t.integer  "node_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "node_user_relationships", ["node_id", "user_id"], :name => "index_node_user_relationships_on_node_id_and_user_id", :unique => true
  add_index "node_user_relationships", ["node_id"], :name => "index_node_user_relationships_on_node_id"
  add_index "node_user_relationships", ["user_id"], :name => "index_node_user_relationships_on_user_id"

  create_table "nodes", :force => true do |t|
    t.string   "name"
    t.string   "continent"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "link"
    t.integer  "user_id"
    t.integer  "node_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["node_id", "created_at"], :name => "index_notes_on_node_id_and_created_at"
  add_index "notes", ["user_id", "created_at"], :name => "index_notes_on_user_id_and_created_at"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "users", :force => true do |t|
    t.string   "handle"
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",              :default => false
    t.string   "salt"
  end

  add_index "users", ["email"], :name => "email", :unique => true
  add_index "users", ["handle"], :name => "handle", :unique => true

end
