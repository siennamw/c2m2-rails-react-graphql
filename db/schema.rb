# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_20_025900) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "catalogers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "id_integer"
    t.string "name", null: false
    t.string "email", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.bigint "created_by_id_integer"
    t.boolean "admin", default: false, null: false
    t.bigint "updated_by_id_integer"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.uuid "created_by_id"
    t.uuid "updated_by_id"
    t.index ["admin"], name: "index_catalogers_on_admin"
    t.index ["created_by_id_integer"], name: "index_catalogers_on_created_by_id_integer"
    t.index ["email"], name: "index_catalogers_on_email", unique: true
    t.index ["updated_by_id_integer"], name: "index_catalogers_on_updated_by_id_integer"
  end

  create_table "collections", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.bigint "repository_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "created_by_id_integer"
    t.bigint "updated_by_id_integer"
    t.string "finding_aid_link"
    t.boolean "deleted", default: false, null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id"
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.uuid "repository_uuid", null: false
    t.index ["created_by_id_integer"], name: "index_collections_on_created_by_id_integer"
    t.index ["deleted"], name: "index_collections_on_deleted"
    t.index ["name"], name: "index_collections_on_name", unique: true
    t.index ["repository_id"], name: "index_collections_on_repository_id"
    t.index ["updated_by_id_integer"], name: "index_collections_on_updated_by_id_integer"
  end

  create_table "collections_resources", id: false, force: :cascade do |t|
    t.bigint "resource_id", null: false
    t.bigint "collection_id", null: false
    t.uuid "collection_uuid", null: false
    t.uuid "resource_uuid", null: false
    t.index ["collection_id", "resource_id"], name: "index_collections_resources_on_collection_id_and_resource_id", unique: true
    t.index ["resource_id", "collection_id"], name: "index_collections_resources_on_resource_id_and_collection_id", unique: true
  end

  create_table "composers", force: :cascade do |t|
    t.string "name", null: false
    t.string "imdb_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "created_by_id_integer"
    t.bigint "updated_by_id_integer"
    t.boolean "deleted", default: false, null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id"
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.index ["created_by_id_integer"], name: "index_composers_on_created_by_id_integer"
    t.index ["deleted"], name: "index_composers_on_deleted"
    t.index ["imdb_link"], name: "index_composers_on_imdb_link", unique: true
    t.index ["name"], name: "index_composers_on_name", unique: true
    t.index ["updated_by_id_integer"], name: "index_composers_on_updated_by_id_integer"
  end

  create_table "composers_works", id: false, force: :cascade do |t|
    t.bigint "composer_id", null: false
    t.bigint "work_id", null: false
    t.uuid "composer_uuid", null: false
    t.uuid "work_uuid", null: false
    t.index ["composer_id", "work_id"], name: "index_composers_works_on_composer_id_and_work_id", unique: true
    t.index ["work_id", "composer_id"], name: "index_composers_works_on_work_id_and_composer_id", unique: true
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "created_by_id_integer"
    t.bigint "updated_by_id_integer"
    t.boolean "deleted", default: false, null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id"
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.index ["created_by_id_integer"], name: "index_countries_on_created_by_id_integer"
    t.index ["deleted"], name: "index_countries_on_deleted"
    t.index ["name"], name: "index_countries_on_name", unique: true
    t.index ["updated_by_id_integer"], name: "index_countries_on_updated_by_id_integer"
  end

  create_table "directors", force: :cascade do |t|
    t.string "name", null: false
    t.string "imdb_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "created_by_id_integer"
    t.bigint "updated_by_id_integer"
    t.boolean "deleted", default: false, null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id"
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.index ["created_by_id_integer"], name: "index_directors_on_created_by_id_integer"
    t.index ["deleted"], name: "index_directors_on_deleted"
    t.index ["imdb_link"], name: "index_directors_on_imdb_link", unique: true
    t.index ["name"], name: "index_directors_on_name", unique: true
    t.index ["updated_by_id_integer"], name: "index_directors_on_updated_by_id_integer"
  end

  create_table "directors_works", id: false, force: :cascade do |t|
    t.bigint "director_id", null: false
    t.bigint "work_id", null: false
    t.uuid "director_uuid", null: false
    t.uuid "work_uuid", null: false
    t.index ["director_id", "work_id"], name: "index_directors_works_on_director_id_and_work_id", unique: true
    t.index ["work_id", "director_id"], name: "index_directors_works_on_work_id_and_director_id", unique: true
  end

  create_table "material_formats", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "created_by_id_integer"
    t.bigint "updated_by_id_integer"
    t.boolean "deleted", default: false, null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id"
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.index ["created_by_id_integer"], name: "index_material_formats_on_created_by_id_integer"
    t.index ["deleted"], name: "index_material_formats_on_deleted"
    t.index ["name"], name: "index_material_formats_on_name", unique: true
    t.index ["updated_by_id_integer"], name: "index_material_formats_on_updated_by_id_integer"
  end

  create_table "media_types", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "created_by_id_integer"
    t.bigint "updated_by_id_integer"
    t.boolean "deleted", default: false, null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id"
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.index ["created_by_id_integer"], name: "index_media_types_on_created_by_id_integer"
    t.index ["deleted"], name: "index_media_types_on_deleted"
    t.index ["name"], name: "index_media_types_on_name", unique: true
    t.index ["updated_by_id_integer"], name: "index_media_types_on_updated_by_id_integer"
  end

  create_table "orchestrators_works", id: false, force: :cascade do |t|
    t.bigint "composer_id", null: false
    t.bigint "work_id", null: false
    t.uuid "composer_uuid", null: false
    t.uuid "work_uuid", null: false
    t.index ["composer_id", "work_id"], name: "index_orch_films_on_orch_id_and_film_id", unique: true
    t.index ["work_id", "composer_id"], name: "index_orch_films_on_film_id_and_orch_id", unique: true
  end

  create_table "production_companies", force: :cascade do |t|
    t.string "name", null: false
    t.text "contact_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "created_by_id_integer"
    t.bigint "updated_by_id_integer"
    t.boolean "deleted", default: false, null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id"
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.index ["created_by_id_integer"], name: "index_production_companies_on_created_by_id_integer"
    t.index ["deleted"], name: "index_production_companies_on_deleted"
    t.index ["name"], name: "index_production_companies_on_name", unique: true
    t.index ["updated_by_id_integer"], name: "index_production_companies_on_updated_by_id_integer"
  end

  create_table "production_companies_works", id: false, force: :cascade do |t|
    t.bigint "production_company_id", null: false
    t.bigint "work_id", null: false
    t.uuid "production_company_uuid", null: false
    t.uuid "work_uuid", null: false
    t.index ["production_company_id", "work_id"], name: "index_pcs_films_on_pc_id_and_film_id", unique: true
    t.index ["work_id", "production_company_id"], name: "index_pcs_films_on_film_id_and_pc_id", unique: true
  end

  create_table "repositories", force: :cascade do |t|
    t.string "name", null: false
    t.string "location", null: false
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "created_by_id_integer"
    t.bigint "updated_by_id_integer"
    t.boolean "deleted", default: false, null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id"
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.index ["created_by_id_integer"], name: "index_repositories_on_created_by_id_integer"
    t.index ["deleted"], name: "index_repositories_on_deleted"
    t.index ["name"], name: "index_repositories_on_name", unique: true
    t.index ["updated_by_id_integer"], name: "index_repositories_on_updated_by_id_integer"
  end

  create_table "resources", force: :cascade do |t|
    t.string "digital_copy_link"
    t.text "citation_source"
    t.text "cataloging_notes"
    t.bigint "material_format_id", null: false
    t.bigint "created_by_id_integer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "publication_status", default: "draft", null: false
    t.bigint "updated_by_id_integer"
    t.bigint "work_id"
    t.boolean "deleted", default: false, null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id"
    t.uuid "material_format_uuid", null: false
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.uuid "work_uuid", null: false
    t.index ["created_by_id_integer"], name: "index_resources_on_created_by_id_integer"
    t.index ["deleted"], name: "index_resources_on_deleted"
    t.index ["material_format_id"], name: "index_resources_on_material_format_id"
    t.index ["publication_status"], name: "index_resources_on_publication_status"
    t.index ["updated_by_id_integer"], name: "index_resources_on_updated_by_id_integer"
    t.index ["work_id"], name: "index_resources_on_work_id"
  end

  create_table "works", force: :cascade do |t|
    t.string "title", null: false
    t.string "secondary_title"
    t.text "alias_alternates"
    t.string "imdb_link"
    t.integer "year", null: false
    t.bigint "country_id"
    t.bigint "media_type_id"
    t.bigint "created_by_id_integer"
    t.bigint "updated_by_id_integer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "deleted", default: false, null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id"
    t.uuid "country_uuid"
    t.uuid "media_type_uuid", null: false
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.index ["country_id"], name: "index_works_on_country_id"
    t.index ["created_by_id_integer"], name: "index_works_on_created_by_id_integer"
    t.index ["deleted"], name: "index_works_on_deleted"
    t.index ["imdb_link"], name: "index_works_on_imdb_link", unique: true
    t.index ["media_type_id"], name: "index_works_on_media_type_id"
    t.index ["updated_by_id_integer"], name: "index_works_on_updated_by_id_integer"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "catalogers", "catalogers", column: "created_by_id"
  add_foreign_key "catalogers", "catalogers", column: "updated_by_id"
  add_foreign_key "collections", "catalogers", column: "created_by_id"
  add_foreign_key "collections", "catalogers", column: "updated_by_id"
  add_foreign_key "collections", "repositories"
  add_foreign_key "collections_resources", "collections"
  add_foreign_key "collections_resources", "resources"
  add_foreign_key "composers", "catalogers", column: "created_by_id"
  add_foreign_key "composers", "catalogers", column: "updated_by_id"
  add_foreign_key "composers_works", "composers"
  add_foreign_key "composers_works", "works"
  add_foreign_key "countries", "catalogers", column: "created_by_id"
  add_foreign_key "countries", "catalogers", column: "updated_by_id"
  add_foreign_key "directors", "catalogers", column: "created_by_id"
  add_foreign_key "directors", "catalogers", column: "updated_by_id"
  add_foreign_key "directors_works", "directors"
  add_foreign_key "directors_works", "works"
  add_foreign_key "material_formats", "catalogers", column: "created_by_id"
  add_foreign_key "material_formats", "catalogers", column: "updated_by_id"
  add_foreign_key "media_types", "catalogers", column: "created_by_id"
  add_foreign_key "media_types", "catalogers", column: "updated_by_id"
  add_foreign_key "orchestrators_works", "composers"
  add_foreign_key "orchestrators_works", "works"
  add_foreign_key "production_companies", "catalogers", column: "created_by_id"
  add_foreign_key "production_companies", "catalogers", column: "updated_by_id"
  add_foreign_key "production_companies_works", "production_companies"
  add_foreign_key "production_companies_works", "works"
  add_foreign_key "repositories", "catalogers", column: "created_by_id"
  add_foreign_key "repositories", "catalogers", column: "updated_by_id"
  add_foreign_key "resources", "catalogers", column: "created_by_id"
  add_foreign_key "resources", "catalogers", column: "updated_by_id"
  add_foreign_key "resources", "material_formats"
  add_foreign_key "resources", "works"
  add_foreign_key "works", "catalogers", column: "created_by_id"
  add_foreign_key "works", "catalogers", column: "updated_by_id"
  add_foreign_key "works", "countries"
  add_foreign_key "works", "media_types"
end
