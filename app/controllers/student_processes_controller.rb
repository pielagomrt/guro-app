class StudentProcessesController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_section
  before_action :set_student

  def update_student
    @student.update(params_student)
  end

  def update_student_seatwork
    @student.seatworks.find(params[:seatwork_id]).update(params_score)
  end

  def update_student_homework
    @student.homeworks.find(params[:homework_id]).update(params_score)
  end

  def update_student_project
    @student.projects.find(params[:project_id]).update(params_score)
  end

  def update_student_exam
    @student.exams.find(params[:exam_id]).update(params_score)
  end

  def destroy_student
    @student.destroy
  end

  def destroy_student_seatwork
    @student.seatworks.find(params[:seatwork_id]).destroy
  end

  def destroy_student_homework
    @student.homeworks.find(params[:homework_id]).destroy
  end

  def destroy_student_project
    @student.projects.find(params[:project_id]).destroy
  end

  def destroy_student_exam
    @student.exams.find(params[:exam_id]).destroy
  end

  def destroy_student_attendance
    @student.absents.find(params[:absent_id]).destroy
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
