class CreateStudentExams < ActiveRecord::Migration[6.0]
  def change
    create_table :student_exams do |t|
      t.integer :score
      # t.belongs_to Section::Exam, index: true, foreign_key: true
      # t.belongs_to Section::Quarter, index: true, foreign_key: true
      t.belongs_to :student, index: true, foreign_key: true
      t.timestamps
    end
  end
end
