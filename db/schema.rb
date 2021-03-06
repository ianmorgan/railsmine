# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090814070818) do

  create_table "books", :force => true do |t|
    t.string "title"
    t.string "asin"
    t.string "author"
    t.string "publisher"
    t.date   "published_date"
  end

  create_table "books_categories", :force => true do |t|
    t.integer "book_id"
    t.integer "category_id"
  end

  create_table "categories", :force => true do |t|
    t.string "name"
  end

  create_table "documents", :force => true do |t|
    t.string   "title"
    t.string   "file_path"
    t.string   "category"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source"
    t.text     "abstract"
    t.string   "url"
  end

  create_table "site_visitor_histories", :force => true do |t|
    t.integer  "site_visitor_id"
    t.string   "displayable_string"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_visitors", :force => true do |t|
    t.string   "cookie"
    t.datetime "first_visit"
    t.datetime "latest_visit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
