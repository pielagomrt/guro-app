class SectionProcessesController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_section
  before_action :set_active_quarter, except: [:update_section]

  def update_section
    @section.update(params_section)
    respond_success('Successfully updated the section', section_path(@section))
  end

  def update_section_seatwork
    @active_quarter.seatworks.find(params[:seatwork_id]).update(params_quarter)
    respond_success('Successfully updated the seatwork', view_section_seatworks_path(@section))
  end

  def update_section_homework
    @active_quarter.homeworks.find(params[:homework_id]).update(params_quarter)
    respond_success('Successfully updated the homework', view_section_homeworks_path(@section))
  end

  def update_section_project
    @active_quarter.projects.find(params[:project_id]).update(params_quarter)
    respond_success('Successfully updated the project', view_section_projects_path(@section))
  end

  def update_section_exam
    @active_quarter.exams.find(params[:exam_id]).update(params_quarter)
    respond_success('Successfully updated the exam', view_section_exams_path(@section))
  end

  def update_section_attendance
    @active_quarter.attendances.find(params[:attendance_id]).update(params_quarter)
    respond_success('Successfully updated the attendance', view_section_attendances_path(@section))
  end

  def section_report_to_email
    ReportMailer.with(section: @section, teacher: current_teacher).section_summary.deliver_later
    respond_success('Successfully sent the report to your email', section_path(@section))
  end

  def download_report
    pdf = ::Reports::Section.new(@section).to_pdf
    send_data(pdf, filename: "section_report_for_#{@section.name}.pdf", type: 'application/pdf')
  end

  def destroy_section
    @section.destroy
    respond_success('Successfully deleted the section', dashboard_path)
  end

  def destroy_section_seatwork
    @active_quarter.seatworks.find(params[:seatwork_id]).destroy
    respond_success('Successfully deleted the seatwork', view_section_seatworks_path(@section))
  end

  def destroy_section_homework
    @active_quarter.homeworks.find(params[:homework_id]).destroy
    respond_success('Successfully deleted the homework', view_section_homeworks_path(@section))
  end

  def destroy_section_project
    @active_quarter.projects.find(params[:project_id]).destroy
    respond_success('Successfully deleted the project', view_section_projects_path(@section))
  end

  def destroy_section_exam
    @active_quarter.exams.find(params[:exam_id]).destroy
    respond_success('Successfully deleted the exam', view_section_exams_path(@section))
  end

  def destroy_section_attendance
    @active_quarter.attendances.find(params[:attendance_id]).destroy
    respond_success('Successfully deleted the attendance', view_section_attendances_path(@section))
  end

  private

  def set_section
    @section = Section.find_by(id: params[:id], teacher: current_teacher)
  end

  def set_active_quarter
    @active_quarter = @section.quarters.find_by(sequence: @section.active_quarter)
  end

  def params_section
    params.require(:section).permit(:name, :active_quarter)
  end

  def params_quarter
    params.require(:quarter).permit(:title, :max_score, :date)
  end
end
