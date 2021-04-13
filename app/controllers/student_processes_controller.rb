class StudentProcessesController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_section
  before_action :set_student

  def update_student
    @student.update(params_student)
    respond_success('Successfully updated the student', students_path(@section))
  end

  def update_student_seatwork
    @student.seatworks.find(params[:seatwork_id]).update(params_score)
    respond_success('Successfully updated the seatwork', view_student_seatworks_path(@section, @student))
  end

  def update_student_homework
    @student.homeworks.find(params[:homework_id]).update(params_score)
    respond_success('Successfully updated the homework', view_student_homeworks_path(@section, @student))
  end

  def update_student_project
    @student.projects.find(params[:project_id]).update(params_score)
    respond_success('Successfully updated the project', view_student_projects_path(@section, @student))
  end

  def update_student_exam
    @student.exams.find(params[:exam_id]).update(params_score)
    respond_success('Successfully updated the exam', view_student_exams_path(@section, @student))
  end

  def destroy_student
    @student.destroy
    respond_success('Successfully deleted the student', students_path(@section))
  end

  def destroy_student_seatwork
    @student.seatworks.find(params[:seatwork_id]).destroy
    respond_success('Successfully deleted the seatwork', view_student_seatworks_path(@section, @student))
  end

  def destroy_student_homework
    @student.homeworks.find(params[:homework_id]).destroy
    respond_success('Successfully deleted the homework', view_student_homeworks_path(@section, @student))
  end

  def destroy_student_project
    @student.projects.find(params[:project_id]).destroy
    respond_success('Successfully deleted the project', view_student_projects_path(@section, @student))
  end

  def destroy_student_exam
    @student.exams.find(params[:exam_id]).destroy
    respond_success('Successfully deleted the exam', view_student_exams_path(@section, @student))
  end

  def destroy_student_attendance
    @student.absents.find(params[:absent_id]).destroy
    respond_success('Successfully deleted the absent', view_student_absences_path(@section, @student))
  end

  def student_report_to_email
    ReportMailer.with(student: @student).student_summary.deliver_later
    respond_success('Successfully sent the report to the student\'s email', student_path(@section, @student))
  end

  def download_report
    pdf = ::Reports::Student.new(@student).to_pdf
    send_data(pdf, filename: "student_report_for_#{@student.last_name}_#{@student.first_name}.pdf", type: 'application/pdf')
  end

  private

  def set_section
    @section = Section.find_by(id: params[:id], teacher: current_teacher)
  end

  def set_student
    @student = @section.students.find(params[:student_id])
  end

  def params_student
    params.require(:student).permit(:first_name, :last_name, :email)
  end

  def params_score
    params.require(:student_score).permit(:score)
  end
end
