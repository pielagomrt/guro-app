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

ActiveRecord::Schema.define(version: 2021_04_03_003720) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "grading_systems", force: :cascade do |t|
    t.integer "homework"
    t.integer "seatwork"
    t.integer "project"
    t.integer "exam"
    t.integer "attendance"
    t.integer "total"
    t.bigint "teacher_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["teacher_id"], name: "index_grading_systems_on_teacher_id"
  end

  create_table "quarter_attendances", force: :cascade do |t|
    t.date "date"
    t.bigint "quarter_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quarter_id"], name: "index_quarter_attendances_on_quarter_id"
  end

  create_table "quarter_exams", force: :cascade do |t|
    t.string "title"
    t.integer "max_score"
    t.bigint "quarter_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quarter_id"], name: "index_quarter_exams_on_quarter_id"
  end

  create_table "quarter_homeworks", force: :cascade do |t|
    t.string "title"
    t.integer "max_score"
    t.bigint "quarter_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quarter_id"], name: "index_quarter_homeworks_on_quarter_id"
  end

  create_table "quarter_projects", force: :cascade do |t|
    t.string "title"
    t.integer "max_score"
    t.bigint "quarter_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quarter_id"], name: "index_quarter_projects_on_quarter_id"
  end

  create_table "quarter_seatworks", force: :cascade do |t|
    t.string "title"
    t.integer "max_score"
    t.bigint "quarter_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quarter_id"], name: "index_quarter_seatworks_on_quarter_id"
  end

  create_table "quarters", force: :cascade do |t|
    t.integer "sequence"
    t.string "school_year"
    t.bigint "section_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["section_id"], name: "index_quarters_on_section_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string "name"
    t.integer "active_quarter"
    t.bigint "teacher_id"
    t.bigint "grading_system_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["grading_system_id"], name: "index_sections_on_grading_system_id"
    t.index ["teacher_id"], name: "index_sections_on_teacher_id"
  end

  create_table "student_absents", force: :cascade do |t|
    t.bigint "student_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "quarter_id"
    t.bigint "quarter_attendance_id"
    t.index ["quarter_attendance_id"], name: "index_student_absents_on_quarter_attendance_id"
    t.index ["quarter_id"], name: "index_student_absents_on_quarter_id"
    t.index ["student_id"], name: "index_student_absents_on_student_id"
  end

  create_table "student_exams", force: :cascade do |t|
    t.integer "score"
    t.bigint "student_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "quarter_id"
    t.bigint "quarter_exam_id"
    t.index ["quarter_exam_id"], name: "index_student_exams_on_quarter_exam_id"
    t.index ["quarter_id"], name: "index_student_exams_on_quarter_id"
    t.index ["student_id"], name: "index_student_exams_on_student_id"
  end

  create_table "student_homeworks", force: :cascade do |t|
    t.integer "score"
    t.bigint "student_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "quarter_id"
    t.bigint "quarter_homework_id"
    t.index ["quarter_homework_id"], name: "index_student_homeworks_on_quarter_homework_id"
    t.index ["quarter_id"], name: "index_student_homeworks_on_quarter_id"
    t.index ["student_id"], name: "index_student_homeworks_on_student_id"
  end

  create_table "student_projects", force: :cascade do |t|
    t.integer "score"
    t.bigint "student_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "quarter_id"
    t.bigint "quarter_project_id"
    t.index ["quarter_id"], name: "index_student_projects_on_quarter_id"
    t.index ["quarter_project_id"], name: "index_student_projects_on_quarter_project_id"
    t.index ["student_id"], name: "index_student_projects_on_student_id"
  end

  create_table "student_seatworks", force: :cascade do |t|
    t.integer "score"
    t.bigint "student_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "quarter_id"
    t.bigint "quarter_seatwork_id"
    t.index ["quarter_id"], name: "index_student_seatworks_on_quarter_id"
    t.index ["quarter_seatwork_id"], name: "index_student_seatworks_on_quarter_seatwork_id"
    t.index ["student_id"], name: "index_student_seatworks_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.bigint "section_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["section_id"], name: "index_students_on_section_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "subject"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["email"], name: "index_teachers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true
  end

  add_foreign_key "grading_systems", "teachers"
  add_foreign_key "quarter_attendances", "quarters"
  add_foreign_key "quarter_exams", "quarters"
  add_foreign_key "quarter_homeworks", "quarters"
  add_foreign_key "quarter_projects", "quarters"
  add_foreign_key "quarter_seatworks", "quarters"
  add_foreign_key "quarters", "sections"
  add_foreign_key "sections", "grading_systems"
  add_foreign_key "sections", "teachers"
  add_foreign_key "student_absents", "quarter_attendances"
  add_foreign_key "student_absents", "quarters"
  add_foreign_key "student_absents", "students"
  add_foreign_key "student_exams", "quarter_exams"
  add_foreign_key "student_exams", "quarters"
  add_foreign_key "student_exams", "students"
  add_foreign_key "student_homeworks", "quarter_homeworks"
  add_foreign_key "student_homeworks", "quarters"
  add_foreign_key "student_homeworks", "students"
  add_foreign_key "student_projects", "quarter_projects"
  add_foreign_key "student_projects", "quarters"
  add_foreign_key "student_projects", "students"
  add_foreign_key "student_seatworks", "quarter_seatworks"
  add_foreign_key "student_seatworks", "quarters"
  add_foreign_key "student_seatworks", "students"
  add_foreign_key "students", "sections"
end
