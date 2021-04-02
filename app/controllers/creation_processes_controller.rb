class CreationProcessesController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_section, except: [:create_section]
  before_action :set_active_quarter, except: [:create_section]

  def create_section
    section = Section.new(name: params[:details][:name], active_quarter: 1)
    section.teacher = current_teacher
    section.grading_system = GradingSystem.find(params[:grading_system])
    section.save

    students.each do |_, student|
      new_student = Student.new(first_name: student[:first_name], last_name: student[:last_name], email: student[:email])
      new_student.section = section
      new_student.save
    end
  end

  def create_seatwork
    seatwork = @active_quarter.seatworks.create(params_details)

    students.each do |student_id, value|
      new_student_seatwork = Student::Seatwork.new(score: value[:score], student_id: student_id.to_i)
      new_student_seatwork.quarter = @active_quarter
      new_student_seatwork.quarter_seatwork = seatwork
      new_student_seatwork.save
    end
  end

  def create_homework
    homework = @active_quarter.homeworks.create(params_details)

    students.each do |student_id, value|
      new_student_homework = Student::Homework.new(score: value[:score], student_id: student_id.to_i)
      new_student_homework.quarter = @active_quarter
      new_student_homework.quarter_homework = homework
      new_student_homework.save
    end
  end

  def create_project
    project = @active_quarter.projects.create(params_details)

    students.each do |student_id, value|
      new_student_project = Student::Project.new(score: value[:score], student_id: student_id.to_i)
      new_student_project.quarter = @active_quarter
      new_student_project.quarter_project = project
      new_student_project.save
    end
  end

  def create_exam
    exam = @active_quarter.exams.create(params_details)

    students.each do |student_id, value|
      new_student_exam = Student::Exam.new(score: value[:score], student_id: student_id.to_i)
      new_student_exam.quarter = @active_quarter
      new_student_exam.quarter_exam = exam
      new_student_exam.save
    end
  end

  def create_absent
    absent = @active_quarter.attendances.create(params_attendance)
    student = @section.students.find_by(id: params[:student_id])

    new_student_absent = Student::Absent.new
    new_student_absent.student = student
    new_student_absent.quarter = @active_quarter
    new_student_absent.quarter_attendance = absent
    new_student_absent.save
  end

  private

  def set_section
    @section = Section.find_by(id: params[:section_id], teacher: current_teacher)
  end

  def set_active_quarter
    @active_quarter = @section.quarters[-@section.active_quarter]
  end

  def params_details
    params.require(:details).permit(:max_score, :title, :name)
  end

  def params_attendance
    params.require(:attendance).permit(:date)
  end

  def students
    params[:section_students][:students]
  end
end
