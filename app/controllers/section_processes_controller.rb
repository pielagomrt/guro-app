class SectionProcessesController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_section
  before_action :set_active_quarter, except: [:update_section]

  def update_section
    @section.update(params_section)
  end

  def update_section_seatwork
    @active_quarter.seatworks.find(params[:seatwork_id]).update(params_quarter)
  end

  def update_section_homework
    @active_quarter.homeworks.find(params[:homework_id]).update(params_quarter)
  end

  def update_section_project
    @active_quarter.projects.find(params[:project_id]).update(params_quarter)
  end

  def update_section_exam
    @active_quarter.exams.find(params[:exam_id]).update(params_quarter)
  end

  def update_section_attendance
    @active_quarter.attendances.find(params[:attendance_id]).update(params_quarter)
  end

  def destroy_section
    @section.destroy
  end

  def destroy_section_seatwork
    @active_quarter.seatworks.find(params[:seatwork_id]).destroy
  end

  def destroy_section_homework
    @active_quarter.homeworks.find(params[:homework_id]).destroy
  end

  def destroy_section_project
    @active_quarter.projects.find(params[:project_id]).destroy
  end

  def destroy_section_exam
    @active_quarter.exams.find(params[:exam_id]).destroy
  end

  def destroy_section_attendance
    @active_quarter.attendances.find(params[:attendance_id]).destroy
  end

  private

  def set_section
    @section = Section.find_by(id: params[:id], teacher: current_teacher)
  end

  def set_active_quarter
    @active_quarter = @section.quarters[-@section.active_quarter]
  end

  def params_section
    params.require(:section).permit(:name, :active_quarter)
  end

  def params_quarter
    params.require(:quarter).permit(:title, :max_score, :date)
  end
end
