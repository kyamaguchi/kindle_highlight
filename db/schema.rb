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

ActiveRecord::Schema.define(version: 2017_06_29_163406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", id: :serial, force: :cascade do |t|
    t.string "asin"
    t.string "title"
    t.string "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "last_annotated_on"
  end

  create_table "data_stores", id: :serial, force: :cascade do |t|
    t.string "key"
    t.json "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "highlights", id: :serial, force: :cascade do |t|
    t.integer "book_id"
    t.text "content"
    t.integer "location"
    t.string "annotation_id"
    t.text "note"
    t.string "note_id"
    t.datetime "fetched_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.index ["book_id"], name: "index_highlights_on_book_id"
  end

  add_foreign_key "highlights", "books"
end
