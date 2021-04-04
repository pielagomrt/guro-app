class FormController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_section_and_students, except: %i[new_section new_grading_system]
  before_action :set_grading_systems, only: [:new_section]

  def new_grading_system; end

  def new_section; end

  def new_seatwork; end

  def new_homework; end

  def new_project; end

  def new_exam; end

  def new_attendance; end

  private

  def set_section_and_students
    @section = Section.find(params[:section_id])
    @students = @section.students.order(:last_name)
  end

  def set_grading_systems
    @grading_systems = GradingSystem.where(teacher_id: current_teacher.id)
  end
end
