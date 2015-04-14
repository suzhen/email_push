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

ActiveRecord::Schema.define(version: 20150414104534) do

  create_table "article_bodies", force: :cascade do |t|
    t.string   "caption",        limit: 255
    t.string   "short_caption",  limit: 255
    t.text     "body",           limit: 65535
    t.text     "formatted_html", limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "article_id",     limit: 4
  end

  add_index "article_bodies", ["article_id"], name: "index_article_bodies_on_article_id", using: :btree

  create_table "articles", force: :cascade do |t|
    t.string   "title",            limit: 255,               null: false
    t.string   "author",           limit: 255
    t.string   "editor",           limit: 255
    t.string   "source",           limit: 255
    t.string   "slug",             limit: 255
    t.string   "meta_description", limit: 255
    t.string   "meta_keywords",    limit: 255
    t.datetime "available_on"
    t.integer  "position",         limit: 4,     default: 0
    t.datetime "deleted_at"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.text     "summary",          limit: 65535
    t.integer  "category_id",      limit: 4
  end

  add_index "articles", ["available_on"], name: "index_articles_on_available_on", using: :btree
  add_index "articles", ["category_id"], name: "index_articles_on_category_id", using: :btree
  add_index "articles", ["deleted_at"], name: "index_articles_on_deleted_at", using: :btree
  add_index "articles", ["slug"], name: "index_articles_on_slug", unique: true, using: :btree
  add_index "articles", ["title"], name: "index_articles_on_title", using: :btree

  create_table "assets", force: :cascade do |t|
    t.integer  "attachment_file_size",    limit: 4
    t.integer  "attachment_width",        limit: 4
    t.integer  "attachment_height",       limit: 4
    t.string   "attachment",              limit: 255
    t.string   "attachment_content_type", limit: 255
    t.string   "attachment_url",          limit: 255
    t.integer  "position",                limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "viewable_id",             limit: 4
    t.string   "viewable_type",           limit: 255
  end

  add_index "assets", ["viewable_type", "viewable_id"], name: "index_assets_on_viewable_type_and_viewable_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "slug",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", unique: true, using: :btree

  create_table "client_groups", id: false, force: :cascade do |t|
    t.integer "client_id", limit: 4
    t.integer "group_id",  limit: 4
  end

  add_index "client_groups", ["client_id"], name: "index_client_groups_on_client_id", using: :btree
  add_index "client_groups", ["group_id"], name: "index_client_groups_on_group_id", using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "tel",        limit: 255
    t.string   "fax",        limit: 255
    t.string   "address",    limit: 255
    t.string   "mobile",     limit: 255
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "company",    limit: 255
    t.string   "postcode",   limit: 255
  end

  add_index "clients", ["company"], name: "index_clients_on_company", using: :btree
  add_index "clients", ["email"], name: "index_clients_on_email", using: :btree
  add_index "clients", ["name"], name: "index_clients_on_name", using: :btree

  create_table "email_articles", id: false, force: :cascade do |t|
    t.integer "email_id",   limit: 4
    t.integer "article_id", limit: 4
  end

  add_index "email_articles", ["article_id"], name: "index_email_articles_on_article_id", using: :btree
  add_index "email_articles", ["email_id"], name: "index_email_articles_on_email_id", using: :btree

  create_table "email_groups", id: false, force: :cascade do |t|
    t.integer "email_id", limit: 4
    t.integer "group_id", limit: 4
  end

  add_index "email_groups", ["email_id"], name: "index_email_groups_on_email_id", using: :btree
  add_index "email_groups", ["group_id"], name: "index_email_groups_on_group_id", using: :btree

  create_table "emails", force: :cascade do |t|
    t.string   "subject",    limit: 255
    t.text     "body",       limit: 4294967295
    t.datetime "sent_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "matrix_id",  limit: 4
  end

  add_index "emails", ["matrix_id"], name: "index_emails_on_matrix_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "matrices", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
