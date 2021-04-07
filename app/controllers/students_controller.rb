class StudentsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_student, except: [:index]
  before_action :set_active_quarter, except: [:index]

  def index
    @section = Section.find(params[:id])
    @students = Section.find(params[:id]).students
  end

  def show; end

  def view_seatworks
    @student_seatworks = @student.seatworks.where(quarter_id: @active_quarter.id)
  end

  def view_homeworks
    @student_homeworks = @student.homeworks.where(quarter_id: @active_quarter.id)
  end

  def view_projects
    @student_projects = @student.projects.where(quarter_id: @active_quarter.id)
  end

  def view_exams
    @student_exams = @student.exams.where(quarter_id: @active_quarter.id)
  end

  def view_absences
    @student_absents = @student.absents.where(quarter_id: @active_quarter.id)
  end

  private

  def set_student
    @student = Student.find_by(id: params[:student_id], section_id: params[:id])
  end

  def set_active_quarter
    @section = @student.section
    @active_quarter = @section.quarters.find_by(sequence: @section.active_quarter)
  end
end
