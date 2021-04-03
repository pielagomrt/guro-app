require 'factory_bot_rails'
require 'faker'

num_of_teachers = 2
num_of_sections = 2
num_of_students = 15

FactoryBot.create_list(:teacher, num_of_teachers)

Teacher.all.each do |teacher|

  # GENERATE GRADING SYSTEMS
  num_of_sections.times do |i|
    new_grading_system = GradingSystem.new( homework: 20,
                                            seatwork: 20,
                                            project: 20,
                                            exam: 20,
                                            attendance: 20)
    new_grading_system.teacher = teacher
    new_grading_system.save
  end

  # GENERATE SECTIONS AND 1st QUARTER FOR EACH
  num_of_sections.times do |i|
    new_section = Section.new(name: Faker::Ancient.god, 
                              active_quarter: 1)
    new_section.grading_system = teacher.grading_systems[i]
    new_section.teacher = teacher
    new_section.save

    new_quarter = Quarter.new(school_year: '2021-2022', sequence: 1)
    new_quarter.section = new_section
    new_quarter.save
  end

  # GENERATE STUDENTS
  num_of_students.times do |i|
    student = Student.new(first_name: Faker::Name.first_name, 
                          last_name: Faker::Name.last_name, 
                          email: Faker::Internet.safe_email)
    student.section = teacher.sections.sample
    student.save
  end

  # GENERATE 2 REQUIREMENT OF TYPE (SW, HW etc..) FOR EACH QUARTER
  teacher.sections.each do |section|
    active_quarter = section.quarters[-section.active_quarter]

    2.times do |i|
      active_quarter.homeworks    << Quarter::Homework.create(title: Faker::Movie.quote, max_score: 50)
      active_quarter.seatworks    << Quarter::Seatwork.create(title: Faker::Movie.quote, max_score: 50)
      active_quarter.projects     << Quarter::Project.create(title: Faker::Movie.quote, max_score: 100)
      active_quarter.exams        << Quarter::Exam.create(title: Faker::Movie.quote, max_score: 100)
      active_quarter.attendances  << Quarter::Attendance.create(date: Faker::Date.backward(days: 30))
    end
  end
  
  # GENERATE INTSANCES OF EACH FOR STUDENT
  teacher.sections.each do |section|
    section.students.each do |student|
      active_quarter_num = student.section.active_quarter
      active_quarter = student.section.quarters[-active_quarter_num]
      
      active_quarter.homeworks.each do |quarter_homework|
        student_homework = student.homeworks.new(score: 25)
        student_homework.quarter = active_quarter
        student_homework.quarter_homework = quarter_homework
        student_homework.save
      end

      active_quarter.seatworks.each do |quarter_seatwork|
        student_seatwork = student.seatworks.new(score: 25)
        student_seatwork.quarter = active_quarter
        student_seatwork.quarter_seatwork = quarter_seatwork
        student_seatwork.save
      end

      active_quarter.exams.each do |quarter_exam|
        student_exam = student.exams.new(score: 95)
        student_exam.quarter = active_quarter
        student_exam.quarter_exam = quarter_exam
        student_exam.save
      end

      active_quarter.projects.each do |quarter_project|
        student_project = student.projects.new(score: 85)
        student_project.quarter = active_quarter
        student_project.quarter_project = quarter_project
        student_project.save
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
