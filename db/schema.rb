# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_27_221356) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "activities", force: :cascade do |t|
    t.string "trackable_type"
    t.bigint "trackable_id"
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "key"
    t.text "parameters"
    t.string "recipient_type"
    t.bigint "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_activities_on_owner_type_and_owner_id"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient_type_and_recipient_id"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "ahoy_events", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["properties"], name: "index_ahoy_events_on_properties", opclass: :jsonb_path_ops, using: :gin
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.bigint "user_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "ancestry"
    t.text "type_of_products"
    t.text "conditions_allowed"
    t.text "approval_required"
    t.text "image_data"
    t.boolean "pause", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "views", default: 0
    t.string "slug"
    t.index ["ancestry"], name: "index_categories_on_ancestry"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "contacts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "company"
    t.string "email"
    t.string "phone_number"
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "impressions", force: :cascade do |t|
    t.string "impressionable_type"
    t.integer "impressionable_id"
    t.integer "user_id"
    t.string "controller_name"
    t.string "action_name"
    t.string "view_name"
    t.string "request_hash"
    t.string "ip_address"
    t.string "session_hash"
    t.text "message"
    t.text "referrer"
    t.text "params"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index"
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "price_histories", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_id"
    t.bigint "seller_id"
    t.bigint "seller_product_id"
    t.integer "unit_price_cents", default: 0, null: false
    t.string "unit_price_currency", default: "USD", null: false
    t.index ["product_id"], name: "index_price_histories_on_product_id"
    t.index ["seller_id"], name: "index_price_histories_on_seller_id"
    t.index ["seller_product_id"], name: "index_price_histories_on_seller_product_id"
  end

  create_table "pricings", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "unit_price_cents", default: 0, null: false
    t.string "unit_price_currency", default: "USD", null: false
    t.integer "order_price_cents", default: 0, null: false
    t.string "order_price_currency", default: "USD", null: false
    t.integer "sale_price_cents", default: 0, null: false
    t.string "sale_price_currency", default: "USD", null: false
    t.integer "retail_price_cents", default: 0, null: false
    t.string "retail_price_currency", default: "USD", null: false
    t.datetime "sale_start"
    t.datetime "sale_end"
    t.bigint "product_id"
    t.bigint "seller_product_id"
    t.bigint "seller_id"
    t.index ["product_id"], name: "index_pricings_on_product_id"
    t.index ["seller_id"], name: "index_pricings_on_seller_id"
    t.index ["seller_product_id"], name: "index_pricings_on_seller_product_id"
  end

  create_table "privacies", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.boolean "pause"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_barcodes", force: :cascade do |t|
    t.string "barcode"
    t.string "gtin14"
    t.string "ean13"
    t.string "upc"
    t.string "prefix"
    t.string "prefix_name"
    t.string "country_code"
    t.string "price"
    t.string "base_gtin14"
    t.boolean "variable"
    t.boolean "restricted"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_id"
    t.index ["product_id"], name: "index_product_barcodes_on_product_id"
  end

  create_table "product_likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_product_likes_on_deleted_at"
  end

  create_table "product_photos", force: :cascade do |t|
    t.bigint "product_id"
    t.text "image_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_product_photos_on_product_id"
  end

  create_table "product_variations", force: :cascade do |t|
    t.string "name"
    t.string "field_type"
    t.boolean "required"
    t.bigint "category_id"
    t.boolean "pause", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_product_variations_on_category_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.hstore "variations"
    t.string "country_code"
    t.string "barcode"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "category_id"
    t.bigint "owner_user_id"
    t.bigint "owner_seller_id"
    t.datetime "deleted_at"
    t.integer "views", default: 0
    t.string "slug"
    t.bigint "product_barcode_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["deleted_at"], name: "index_products_on_deleted_at"
    t.index ["owner_seller_id"], name: "index_products_on_owner_seller_id"
    t.index ["owner_user_id"], name: "index_products_on_owner_user_id"
    t.index ["product_barcode_id"], name: "index_products_on_product_barcode_id"
    t.index ["slug"], name: "index_products_on_slug", unique: true
  end

  create_table "searchjoy_searches", force: :cascade do |t|
    t.bigint "user_id"
    t.string "source"
    t.string "search_type"
    t.string "query"
    t.string "normalized_query"
    t.integer "results_count"
    t.datetime "created_at"
    t.string "convertable_type"
    t.bigint "convertable_id"
    t.datetime "converted_at"
    t.index ["convertable_type", "convertable_id"], name: "index_searchjoy_searches_on_convertable"
    t.index ["created_at"], name: "index_searchjoy_searches_on_created_at"
    t.index ["search_type", "created_at"], name: "index_searchjoy_searches_on_search_type_and_created_at"
    t.index ["search_type", "normalized_query", "created_at"], name: "index_searchjoy_searches_on_search_type_query"
    t.index ["user_id"], name: "index_searchjoy_searches_on_user_id"
  end

  create_table "seller_accounts", force: :cascade do |t|
    t.integer "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "seller_id"
    t.bigint "seller_location_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_seller_accounts_on_deleted_at"
    t.index ["seller_id"], name: "index_seller_accounts_on_seller_id"
    t.index ["seller_location_id"], name: "index_seller_accounts_on_seller_location_id"
    t.index ["user_id"], name: "index_seller_accounts_on_user_id"
  end

  create_table "seller_charges", force: :cascade do |t|
    t.bigint "seller_id", null: false
    t.string "stripe_id"
    t.integer "amount"
    t.integer "amount_refunded"
    t.string "card_brand"
    t.string "card_last4"
    t.string "card_exp_month"
    t.string "card_exp_year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_seller_charges_on_deleted_at"
    t.index ["seller_id"], name: "index_seller_charges_on_seller_id"
  end

  create_table "seller_locations", force: :cascade do |t|
    t.string "name"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "zip"
    t.string "state"
    t.string "country"
    t.float "longitude"
    t.float "latitude"
    t.string "phone"
    t.boolean "pause", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "seller_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_seller_locations_on_deleted_at"
    t.index ["seller_id"], name: "index_seller_locations_on_seller_id"
  end

  create_table "seller_plans", force: :cascade do |t|
    t.string "name"
    t.integer "amount"
    t.string "interval"
    t.string "stripe_id"
    t.integer "num_of_products"
    t.integer "num_of_locations"
    t.integer "num_of_sub_accounts"
    t.string "analytics"
    t.boolean "pause", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "seller_products", force: :cascade do |t|
    t.string "sku"
    t.string "harmonized_system_code"
    t.string "packaging"
    t.text "packaging_details"
    t.string "supply_ability"
    t.string "weight"
    t.integer "units_per_case"
    t.boolean "pause"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "unit_price_cents", default: 0, null: false
    t.string "unit_price_currency", default: "USD", null: false
    t.integer "order_price_cents", default: 0, null: false
    t.string "order_price_currency", default: "USD", null: false
    t.integer "retail_price_cents", default: 0, null: false
    t.string "retail_price_currency", default: "USD", null: false
    t.integer "sale_price_cents", default: 0, null: false
    t.string "sale_price_currency", default: "USD", null: false
    t.datetime "sale_start"
    t.datetime "sale_end"
    t.integer "handling_time"
    t.integer "max_order_quantity"
    t.bigint "product_id"
    t.bigint "seller_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_seller_products_on_deleted_at"
    t.index ["product_id"], name: "index_seller_products_on_product_id"
    t.index ["seller_id"], name: "index_seller_products_on_seller_id"
  end

  create_table "seller_subscriptions", force: :cascade do |t|
    t.bigint "seller_id", null: false
    t.string "stripe_id"
    t.string "stripe_plan"
    t.string "status"
    t.datetime "trial_ends_at"
    t.datetime "ends_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_seller_subscriptions_on_deleted_at"
    t.index ["seller_id"], name: "index_seller_subscriptions_on_seller_id"
  end

  create_table "sellers", force: :cascade do |t|
    t.string "name"
    t.string "business_number"
    t.text "description"
    t.string "country"
    t.date "founding_date"
    t.integer "status", default: 0
    t.boolean "pause", default: false
    t.text "image_data"
    t.text "cover_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "owner_id"
    t.datetime "onboarding_completed_at"
    t.string "stripe_id"
    t.string "card_brand"
    t.string "card_last4"
    t.string "card_exp_month"
    t.string "card_exp_year"
    t.datetime "deleted_at"
    t.integer "views", default: 0
    t.string "slug"
    t.index ["deleted_at"], name: "index_sellers_on_deleted_at"
    t.index ["name"], name: "index_sellers_on_name"
    t.index ["owner_id"], name: "index_sellers_on_owner_id"
    t.index ["slug"], name: "index_sellers_on_slug", unique: true
  end

  create_table "terms", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.boolean "pause"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_locations", force: :cascade do |t|
    t.string "name"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "zip"
    t.string "state"
    t.string "country"
    t.float "longitude"
    t.float "latitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_user_locations_on_deleted_at"
    t.index ["user_id"], name: "index_user_locations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "phone_number"
    t.string "time_zone"
    t.string "image_data"
    t.boolean "private", default: false
    t.integer "status", default: 0
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.datetime "deleted_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "product_photos", "products"
  add_foreign_key "seller_charges", "sellers"
  add_foreign_key "seller_subscriptions", "sellers"
end
