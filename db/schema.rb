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

ActiveRecord::Schema.define(version: 20170704081817) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "client_debt_data", force: :cascade do |t|
    t.string "contract_id"
    t.string "amount_beginning"
    t.string "sales"
    t.string "sales_returns"
    t.string "debt_adjustment"
    t.string "payment"
    t.string "amount_returns"
    t.string "amount_the_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "week_id"
    t.index ["week_id"], name: "index_client_debt_data_on_week_id"
  end

  create_table "contractors", force: :cascade do |t|
    t.string "customer_id"
    t.string "customer_code"
    t.string "customer_tin"
    t.string "customer_actual_address"
    t.string "customer_legal_address"
    t.string "customer_type"
    t.string "customer_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contracts", force: :cascade do |t|
    t.string "contract_id"
    t.string "customer_id"
    t.string "contract_code"
    t.string "contract_name"
    t.string "contract_type"
    t.string "currency_id"
    t.string "trading_agent_id"
    t.string "subdivision_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "currencies", force: :cascade do |t|
    t.string "currency_id"
    t.string "currency_code"
    t.string "currency_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "operations", force: :cascade do |t|
    t.string "operation_code"
    t.string "operation_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subdivisions", force: :cascade do |t|
    t.string "subdivision_id"
    t.string "subdivision_code"
    t.string "subdivision_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trading_agents", force: :cascade do |t|
    t.string "trading_agent_id"
    t.string "trading_agent_code"
    t.string "trading_agent_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "preseller"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "weeks", force: :cascade do |t|
    t.datetime "monday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
