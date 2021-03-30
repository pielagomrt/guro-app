class StudentsController < ApplicationController
  before_action :set_student, except: [:index]

  def index
    @students = Student.all
  end

  def show; end

  def view_seatworks
    @student_seatworks = @student.seatworks
  end

  def view_homeworks
    @student_homeworks = @student.homeworks
  end

  def view_projects
    @student_projects = @student.projects
  end

  def view_exams
    @student_exams = @student.exams
  end

  def view_absences
    @student_absents = @student.absents
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end
end
