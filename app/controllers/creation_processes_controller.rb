class CreationProcessesController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_section, except: %i[create_section create_grading_system]
  before_action :set_active_quarter, except: %i[create_section create_grading_system]

  def create_grading_system
    grading_system = GradingSystem.new(params_details)
    grading_system.teacher = current_teacher
    raise CreationProcessError.new(resource: grading_system, path: new_grading_system_form_path) unless grading_system.save

    respond_success('Successfully created the grading system', new_grading_system_form_path)
  end

  def create_section
    year = Time.zone.now.year
    section = Section.new(name: params_details[:name], active_quarter: 1)
    section.teacher = current_teacher
    section.grading_system = GradingSystem.find(params[:grading_system])
    4.times { |i| section.quarters << Quarter.create(sequence: i + 1, school_year: "#{year}-#{year + 1}") }
    raise CreationProcessError.new(resource: section, path: new_section_form_path) unless section.save

    students.each do |_, student|
      new_student = Student.new(first_name: student[:first_name], last_name: student[:last_name], email: student[:email])
      new_student.section = section
      raise CreationProcessError.new(resource: new_student, path: new_section_form_path) unless new_student.save
    end

    respond_success('Successfully created the section', new_section_form_path)
  end

  def create_seatwork
    seatwork = @active_quarter.seatworks.new(params_details)
    raise CreationProcessError.new(resource: seatwork, path: new_seatwork_form_path) unless seatwork.save

    raise InvalidScoresError.new(path: new_seatwork_form_path) unless validate_scores(seatwork)

    students.each do |student_id, value|
      student_seatwork = Student::Seatwork.new(score: value[:score], student_id: student_id.to_i)
      student_seatwork.quarter = @active_quarter
      student_seatwork.quarter_seatwork = seatwork
      raise CreationProcessError.new(resource: student_seatwork, path: new_seatwork_form_path) unless student_seatwork.save
    end

    respond_success('Successfully created the seatwork', new_seatwork_form_path)
  end

  def create_homework
    homework = @active_quarter.homeworks.new(params_details)
    raise CreationProcessError.new(resource: homework, path: new_homework_form_path) unless homework.save

    raise InvalidScoresError.new(path: new_homework_form_path) unless validate_scores(homework)

    students.each do |student_id, value|
      student_homework = Student::Homework.new(score: value[:score], student_id: student_id.to_i)
      student_homework.quarter = @active_quarter
      student_homework.quarter_homework = homework
      raise CreationProcessError.new(resource: student_homework, path: new_homework_form_path) unless student_homework.save
    end

    respond_success('Successfully created the homework', new_homework_form_path)
  end

  def create_project
    project = @active_quarter.projects.create(params_details)
    raise CreationProcessError.new(resource: project, path: new_project_form_path) unless project.save

    raise InvalidScoresError.new(path: new_project_form_path) unless validate_scores(project)

    students.each do |student_id, value|
      student_project = Student::Project.new(score: value[:score], student_id: student_id.to_i)
      student_project.quarter = @active_quarter
      student_project.quarter_project = project
      raise CreationProcessError.new(resource: student_project, path: new_project_form_path) unless student_project.save
    end

    respond_success('Successfully created the project', new_project_form_path)
  end

  def create_exam
    exam = @active_quarter.exams.create(params_details)
    raise CreationProcessError.new(resource: exam, path: new_exam_form_path) unless exam.save

    raise InvalidScoresError.new(path: new_exam_form_path) unless validate_scores(exam)

    students.each do |student_id, value|
      student_exam = Student::Exam.new(score: value[:score], student_id: student_id.to_i)
      student_exam.quarter = @active_quarter
      student_exam.quarter_exam = exam
      raise CreationProcessError.new(resource: student_exam, path: new_exam_form_path) unless student_exam.save
    end

    respond_success('Successfully created the exam', new_exam_form_path)
  end

  def create_attendance
    attendance = @active_quarter.attendances.new(params_details)
    raise CreationProcessError.new(resource: attendance, path: new_attendance_form_path) unless attendance.save

    section_students = @section.students.map(&:id)
    present_students = students ? students.keys.map(&:to_i) : []
    absent_students = section_students - present_students

    absent_students.each do |student_id|
      student_absent = Student::Absent.new
      student_absent.student_id = student_id.to_i
      student_absent.quarter = @active_quarter
      student_absent.quarter_attendance = attendance
      raise CreationProcessError.new(resource: student_absent, path: new_attendance_form_path) unless student_absent.save
    end

    respond_success('Successfully created the attendance', new_attendance_form_path)
  end

  private

  def set_section
    @section = Section.find_by(id: params[:section_id], teacher: current_teacher)
  end

  def set_active_quarter
    @active_quarter = @section.quarters.find_by(sequence: @section.active_quarter)
  end

  def params_details
    params.require(:details).permit(:max_score, :title, :name,
                                    :date, :homework, :seatwork,
                                    :project, :exam, :attendance)
  end

  def students
    params[:section_students]
  end

  def validate_scores(requirement)
    scores = students.values.pluck(:score)
    scores.all? { |score| score.to_i <= requirement.max_score }
  end
end
