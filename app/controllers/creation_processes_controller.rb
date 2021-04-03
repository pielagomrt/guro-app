class CreationProcessesController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_section, except: [:create_section]
  before_action :set_active_quarter, except: [:create_section]

  def create_section
    year = Time.zone.now.year
    section = Section.new(name: params_details[:name], active_quarter: 1)
    section.teacher = current_teacher
    section.grading_system = GradingSystem.find(params[:grading_system])
    section.save

    4.times do |i|
      section.quarters << Quarter.create(sequence: i + 1, school_year: "#{year}-#{year + 1}")
      section.save
    end

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

  def create_attendance
    attendance = @active_quarter.attendances.create(params_details)

    students.each do |student_id, is_absent|
      next if is_absent.to_i.positive?

      new_student_absent = Student::Absent.new
      new_student_absent.student_id = student_id.to_i
      new_student_absent.quarter = @active_quarter
      new_student_absent.quarter_attendance = attendance
      new_student_absent.save
    end
  end

  private

  def set_section
    @section = Section.find_by(id: params[:section_id], teacher: current_teacher)
  end

  def set_active_quarter
    @active_quarter = @section.quarters.find_by(sequence: @section.active_quarter)
  end

  def params_details
    params.require(:details).permit(:max_score, :title, :name, :date)
  end

  def students
    params[:section_students]
  end
end
