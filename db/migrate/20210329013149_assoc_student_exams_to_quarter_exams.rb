class AssocStudentExamsToQuarterExams < ActiveRecord::Migration[6.0]
  def change
    add_reference :student_exams, :quarter, foreign_key: true, index: true
    add_reference :student_exams, :quarter_exam, foreign_key: true, index: true
  end
end
