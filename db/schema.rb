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

ActiveRecord::Schema.define(:version => 20100303010906) do

  create_table "customers", :force => true do |t|
    t.string  "name",       :null => false
    t.string  "phone"
    t.string  "address"
    t.string  "references"
    t.integer "store_id"
    t.string  "email"
  end

  create_table "products", :force => true do |t|
    t.string  "product_name",                                                 :null => false
    t.decimal "price",        :precision => 8, :scale => 2,                   :null => false
    t.string  "description"
    t.boolean "active",                                     :default => true, :null => false
  end

  add_index "products", ["product_name"], :name => "index_products_on_product_name"

  create_table "purchase_products", :force => true do |t|
    t.integer  "purchase_id"
    t.integer  "product_id"
    t.integer  "qty",         :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "purchase_products", ["product_id"], :name => "purchase_products_product_id_fk"

  create_table "purchases", :force => true do |t|
    t.integer  "store_id"
    t.integer  "supplier_id"
    t.string   "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "purchases", ["store_id"], :name => "purchases_store_id_fk"
  add_index "purchases", ["supplier_id"], :name => "purchases_supplier_id_fk"

  create_table "sale_products", :force => true do |t|
    t.integer  "product_id",                :null => false
    t.integer  "sale_id",                   :null => false
    t.integer  "qty",        :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sale_products", ["product_id"], :name => "sale_products_product_id_fk"
  add_index "sale_products", ["sale_id"], :name => "sale_products_sale_id_fk"

  create_table "sales", :force => true do |t|
    t.integer  "store_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
  end

  add_index "sales", ["customer_id"], :name => "sales_customer_id_fk"
  add_index "sales", ["store_id"], :name => "sales_store_id_fk"

  create_table "stock_products", :force => true do |t|
    t.integer  "stock_id",   :null => false
    t.integer  "product_id", :null => false
    t.integer  "qty",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stock_products", ["product_id"], :name => "stock_products_product_id_fk"
  add_index "stock_products", ["stock_id"], :name => "stock_products_stock_id_fk"

  create_table "stocks", :force => true do |t|
    t.integer  "store_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stocks", ["store_id"], :name => "stocks_store_id_fk"

  create_table "stores", :force => true do |t|
    t.string  "store_name", :null => false
    t.integer "user_id",    :null => false
  end

  add_index "stores", ["user_id"], :name => "stores_user_id_fk"

  create_table "suppliers", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "phone"
    t.string   "address"
    t.integer  "store_id",   :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "suppliers", ["store_id"], :name => "suppliers_store_id_fk"
  add_index "suppliers", ["user_id"], :name => "suppliers_user_id_fk"

  create_table "users", :force => true do |t|
    t.string  "name",                             :null => false
    t.string  "email",                            :null => false
    t.string  "password_salt",                    :null => false
    t.string  "crypted_password",                 :null => false
    t.string  "persistence_token",                :null => false
    t.integer "login_count",       :default => 0, :null => false
    t.string  "last_login_ip"
  end

  add_foreign_key "purchase_products", "products", :name => "purchase_products_product_id_fk"

  add_foreign_key "purchases", "stores", :name => "purchases_store_id_fk", :dependent => :delete
  add_foreign_key "purchases", "suppliers", :name => "purchases_supplier_id_fk", :dependent => :delete

  add_foreign_key "sale_products", "products", :name => "sale_products_product_id_fk", :dependent => :delete
  add_foreign_key "sale_products", "sales", :name => "sale_products_sale_id_fk", :dependent => :delete

  add_foreign_key "sales", "customers", :name => "sales_customer_id_fk"
  add_foreign_key "sales", "stores", :name => "sales_store_id_fk", :dependent => :delete

  add_foreign_key "stock_products", "products", :name => "stock_products_product_id_fk", :dependent => :delete
  add_foreign_key "stock_products", "stocks", :name => "stock_products_stock_id_fk", :dependent => :delete

  add_foreign_key "stocks", "stores", :name => "stocks_store_id_fk", :dependent => :delete

  add_foreign_key "stores", "users", :name => "stores_user_id_fk", :dependent => :delete

  add_foreign_key "suppliers", "stores", :name => "suppliers_store_id_fk"
  add_foreign_key "suppliers", "users", :name => "suppliers_user_id_fk"

end
