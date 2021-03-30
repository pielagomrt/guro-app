class FormController < ApplicationController
  before_action :set_students, except: [:new_section]

  def new_section; end

  def new_seatwork; end

  def new_homework; end

  def new_project; end

  def new_exam; end

  def new_attendance; end

  private

  def set_students
    @students = Section.find(params[:section_id]).students
  end
end
