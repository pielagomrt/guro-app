class SectionsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_section, except: [:index]
  before_action :set_active_quarter, except: %i[index show]

  def index
    @sections = Section.where(teacher: current_teacher)
  end

  def show; end

  def view_seatworks
    @seatworks = @active_quarter.seatworks
  end

  def view_homeworks
    @homeworks = @active_quarter.homeworks
  end

  def view_projects
    @projects = @active_quarter.projects
  end

  def view_exams
    @exams = @active_quarter.exams
  end

  def view_attendances
    @absences = {}
    @attendances = @active_quarter.attendances
    @attendances.each { |attendance| @absences[attendance.id] = attendance.student_absents.length }
  end

  private

  def set_section
    @section = Section.find_by(id: params[:id], teacher: current_teacher)
  end

  def set_active_quarter
    @active_quarter = @section.quarters.find_by(sequence: @section.active_quarter)
  end
end
