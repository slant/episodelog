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

ActiveRecord::Schema.define(:version => 20110420134540) do

  create_table "episodes", :force => true do |t|
    t.integer  "show_id"
    t.integer  "season"
    t.integer  "episode"
    t.string   "name"
    t.date     "air_date"
    t.text     "synopsis"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "episodes_watched", :force => true do |t|
    t.integer  "user_id"
    t.integer  "episode_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shows", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shows_followed", :force => true do |t|
    t.integer  "user_id"
    t.integer  "show_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
