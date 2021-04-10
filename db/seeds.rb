require 'faker'

num_of_teachers = 2
num_of_sections = 2
num_of_students = 40
num_of_requirements_per_type = 5

# GENERATE TEACHERS
num_of_teachers.times do |teacher_num|
  new_teacher = Teacher.create( first_name: 'Teacher', last_name: "#{teacher_num + 1}",
                                email: Faker::Internet::safe_email,
                                password: '987654321',
                                subject: %w[Chemistry Calculus Biology History Physics].sample)
  new_teacher.confirm
end


Teacher.all.each do |teacher|

  # GENERATE A GRADING SYSTEM
  new_grading_system = GradingSystem.new(homework: 20, seatwork: 20, project: 20, exam: 20, attendance: 20)
  new_grading_system.teacher = teacher
  new_grading_system.save

  # GENERATE SECTIONS AND 4 QUARTERS FOR EACH
  num_of_sections.times do |section_num|
    new_section = Section.new(name: Faker::Ancient.god, active_quarter: 1)
    new_section.grading_system = teacher.grading_systems.first
    new_section.teacher = teacher
    new_section.save

    year = Time.zone.now.year

    4.times do |quarter_num|
      new_quarter = Quarter.new(school_year: "#{year}-#{year + 1}", sequence: quarter_num + 1)
      new_quarter.section = new_section
      new_quarter.save
    end
  end

  # GENERATE STUDENTS
  num_of_students.times do |i|
    student = Student.new(first_name: Faker::Name.first_name, 
                          last_name: Faker::Name.last_name, 
                          email: Faker::Internet.safe_email)
    student.section = teacher.sections.sample
    student.save
  end

  # GENERATE num_of_requirements_per_type (SW, HW etc..) FOR EACH QUARTER
  teacher.sections.each do |section|
    active_quarter = section.quarters.find_by(sequence: section.active_quarter)

    num_of_requirements_per_type.times do |i|
      active_quarter.homeworks    << Quarter::Homework.create(title: "Homework #{i+1} Title", max_score: 20)
      active_quarter.seatworks    << Quarter::Seatwork.create(title: "Seatwork #{i+1} Title", max_score: 20)
      active_quarter.projects     << Quarter::Project.create(title: "Project #{i+1} Title", max_score: 100)
      active_quarter.exams        << Quarter::Exam.create(title: "Exam #{i+1} Title", max_score: 50)
      active_quarter.attendances  << Quarter::Attendance.create(date: Faker::Date.backward(days: 30))
    end
  end
  
  # GENERATE INTSANCES OF EACH FOR STUDENT ONLY ON THE ACTIVE QUARTER
  teacher.sections.each do |section|
    section.students.each do |student|
      active_quarter_sequence = student.section.active_quarter
      active_quarter = student.section.quarters.find_by(sequence: active_quarter_sequence)
      
      active_quarter.homeworks.each do |quarter_homework|
        student_homework = student.homeworks.new(score: Faker::Number.between(from: 10, to: 20))
        student_homework.quarter = active_quarter
        student_homework.quarter_homework = quarter_homework
        student_homework.save
      end

      active_quarter.seatworks.each do |quarter_seatwork|
        student_seatwork = student.seatworks.new(score: Faker::Number.between(from: 10, to: 20))
        student_seatwork.quarter = active_quarter
        student_seatwork.quarter_seatwork = quarter_seatwork
        student_seatwork.save
      end

      active_quarter.projects.each do |quarter_project|
        student_project = student.projects.new(score: Faker::Number.between(from: 75, to: 100))
        student_project.quarter = active_quarter
        student_project.quarter_project = quarter_project
        student_project.save
      end

      active_quarter.exams.each do |quarter_exam|
        student_exam = student.exams.new(score: Faker::Number.between(from: 25, to: 50))
        student_exam.quarter = active_quarter
        student_exam.quarter_exam = quarter_exam
        student_exam.save
      end

      active_quarter.attendances.each do |quarter_attendance|
        student_absent = student.absents.new
        student_absent.quarter = active_quarter
        student_absent.quarter_attendance = quarter_attendance
        student_absent.save
      end

    end
  end
end
