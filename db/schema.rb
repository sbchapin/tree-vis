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

ActiveRecord::Schema.define(version: 20140703121523) do

  create_table "entities", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "x"
    t.integer  "y"
    t.integer  "width",       default: 0, null: false
    t.integer  "height",      default: 0, null: false
  end

  create_table "relationships", force: true do |t|
    t.integer  "entity_source_id"
    t.integer  "entity_target_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["entity_source_id"], name: "index_relationships_on_entity_source_id", using: :btree
  add_index "relationships", ["entity_target_id"], name: "index_relationships_on_entity_target_id", using: :btree

  create_table "settings", force: true do |t|
    t.decimal  "bezier_curvature", precision: 4, scale: 3
    t.integer  "bezier_max_curve"
    t.integer  "default_height"
    t.integer  "default_width"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
