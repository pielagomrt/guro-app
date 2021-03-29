class AssocStudentAbsentsToQuarterAttendance < ActiveRecord::Migration[6.0]
  def change
    add_reference :student_absents, :quarter, foreign_key: true, index: true
    add_reference :student_absents, :quarter_attendance, foreign_key: true, index: true
  end
end
