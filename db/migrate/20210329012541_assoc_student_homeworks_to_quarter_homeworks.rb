class AssocStudentHomeworksToQuarterHomeworks < ActiveRecord::Migration[6.0]
  def change
    add_reference :student_homeworks, :quarter, foreign_key: true, index: true
    add_reference :student_homeworks, :quarter_homework, foreign_key: true, index: true
  end
end
