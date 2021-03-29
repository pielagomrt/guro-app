class CreateStudentAbsents < ActiveRecord::Migration[6.0]
  def change
    create_table :student_absents do |t|
      t.belongs_to :student, index: true, foreign_key: true
      t.timestamps
    end
  end
end
