class AssocStudentProjectsToQuarterProjects < ActiveRecord::Migration[6.0]
  def change
    add_reference :student_projects, :quarter, foreign_key: true, index: true
    add_reference :student_projects, :quarter_project, foreign_key: true, index: true
  end
end