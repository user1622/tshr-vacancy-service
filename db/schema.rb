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

ActiveRecord::Schema.define(version: 2020_05_10_165326) do

  create_table "asset", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "assetTypeId"
    t.index ["assetTypeId"], name: "FK_53824cd90f4ae4ed1896f9adeb0"
  end

  create_table "asset_type", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "company", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "department", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "employee", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "birthday"
    t.string "lastName", null: false
    t.string "firstName", null: false
    t.string "position"
    t.string "relativesContacts"
    t.string "email"
    t.string "phone"
    t.string "skype"
    t.datetime "employmentDate"
    t.datetime "probation"
    t.integer "photoId"
    t.integer "departmentId"
    t.integer "curatorId"
    t.integer "companyId"
    t.integer "rate"
    t.index ["companyId"], name: "FK_26c3d513e0832e5abbbdd3d2a88"
    t.index ["curatorId"], name: "FK_84839a519cdbe8b37475b80fddc"
    t.index ["departmentId"], name: "FK_9ad20e4029f9458b6eed0b0c454"
    t.index ["photoId"], name: "REL_2a77e78d6b243797b57e990051", unique: true
  end

  create_table "employee_asset", primary_key: ["employeeId", "assetId"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "employeeId", null: false
    t.integer "assetId", null: false
    t.index ["assetId"], name: "IDX_39b8f3591170d2e2b3c54bb944"
    t.index ["employeeId"], name: "IDX_10e875159f1842a42429f9260b"
  end

  create_table "job_platforms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "url"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "migrations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "timestamp", null: false
    t.string "name", null: false
  end

  create_table "user", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "skype"
    t.string "email", null: false
    t.string "lastName", null: false
    t.string "firstName", null: false
    t.string "password", null: false
  end

  create_table "users_job_platforms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "job_platform_id"
    t.column "session_type", "enum('cookie','token')"
    t.binary "session_data", size: :medium
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["job_platform_id"], name: "index_users_job_platforms_on_job_platform_id"
    t.index ["user_id"], name: "index_users_job_platforms_on_user_id"
  end

  create_table "vacancy", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "reason"
    t.string "compulsoryEducation"
    t.string "experience"
    t.integer "curatorId"
    t.integer "createrId"
    t.integer "departmentId"
    t.integer "companyId"
    t.integer "vacancyTypeId"
    t.string "title"
    t.string "level"
    t.text "other", size: :long
    t.string "levelofEnglish"
    t.text "skills", size: :long
    t.index ["companyId"], name: "FK_b7eb633ebbbdff1d21907939e10"
    t.index ["createrId"], name: "FK_221c313a0cbb2683b4e83553172"
    t.index ["curatorId"], name: "FK_ce885692d92ff74c8e4f07b303d"
    t.index ["departmentId"], name: "FK_faa5e795b9b1e1aa7108450a51c"
    t.index ["vacancyTypeId"], name: "FK_099ae9c742e5e6b5b94104fff21"
  end

  create_table "vacancy_type", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
  end

  add_foreign_key "asset", "asset_type", column: "assetTypeId", name: "FK_53824cd90f4ae4ed1896f9adeb0"
  add_foreign_key "employee", "asset", column: "photoId", name: "FK_2a77e78d6b243797b57e9900517"
  add_foreign_key "employee", "company", column: "companyId", name: "FK_26c3d513e0832e5abbbdd3d2a88"
  add_foreign_key "employee", "department", column: "departmentId", name: "FK_9ad20e4029f9458b6eed0b0c454"
  add_foreign_key "employee", "employee", column: "curatorId", name: "FK_84839a519cdbe8b37475b80fddc"
  add_foreign_key "employee_asset", "asset", column: "assetId", name: "FK_39b8f3591170d2e2b3c54bb9448", on_delete: :cascade
  add_foreign_key "employee_asset", "employee", column: "employeeId", name: "FK_10e875159f1842a42429f9260b2", on_delete: :cascade
  add_foreign_key "vacancy", "company", column: "companyId", name: "FK_b7eb633ebbbdff1d21907939e10"
  add_foreign_key "vacancy", "department", column: "departmentId", name: "FK_faa5e795b9b1e1aa7108450a51c"
  add_foreign_key "vacancy", "employee", column: "curatorId", name: "FK_ce885692d92ff74c8e4f07b303d"
  add_foreign_key "vacancy", "user", column: "createrId", name: "FK_221c313a0cbb2683b4e83553172"
  add_foreign_key "vacancy", "vacancy_type", column: "vacancyTypeId", name: "FK_099ae9c742e5e6b5b94104fff21"
end
