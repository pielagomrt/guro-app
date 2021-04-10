module Reports
  class Student
    attr_reader :student

    def initialize(student)
      @student = student
      @section = @student.section
      @grading_system = @section.grading_system
      @active_quarter = @section.quarters.find_by(sequence: @section.active_quarter)
    end

    def to_html
      ApplicationController.renderer.render('report_mailer/student_summary', assigns: { data: student_data }, layout: false)
    end

    def to_pdf
      WickedPdf.new.pdf_from_string(to_html, page_size: 'A4')
    end

    def to_pdf_to_tmp
      pdf_file_path = "tmp/#{@student.last_name}_#{@student.first_name}_#{Time.zone.now.nsec}.pdf"
      pdf_file = File.new(pdf_file_path, 'w')
      pdf_file.write(to_pdf.force_encoding('UTF-8'))
      pdf_file.close
      pdf_file_path
    end

    private

    def student_data
      data = { student: @student, section: @section, teacher: @section.teacher, grading_system: @grading_system,
              seatworks: [], homeworks: [], exams: [], projects: [], absents: [], grades: {}, final_grade: 0, school_days: 0 }

      quarter_seatworks = @active_quarter.seatworks
      quarter_homeworks = @active_quarter.homeworks
      quarter_projects = @active_quarter.projects
      quarter_exams = @active_quarter.exams
      quarter_attendances = @active_quarter.attendances

      quarter_seatworks_total = quarter_total_of(@active_quarter.seatworks)
      quarter_homeworks_total = quarter_total_of(@active_quarter.homeworks)
      quarter_projects_total = quarter_total_of(@active_quarter.projects)
      quarter_exams_total = quarter_total_of(@active_quarter.exams)
      quarter_attendances_total = @active_quarter.attendances.length.to_f

      @student.seatworks.each do |sw|
        seatwork = {}
        quarter_seatwork = quarter_seatworks.find(sw.quarter_seatwork_id)
        seatwork[:score] = sw.score
        seatwork[:max_score] = quarter_seatwork.max_score
        seatwork[:title] = quarter_seatwork.title
        seatwork[:date] = format_date(quarter_seatwork.created_at)
        data[:seatworks] << seatwork
      end

      @student.homeworks.each do |hw|
        homework = {}
        quarter_homework = quarter_homeworks.find(hw.quarter_homework_id)
        homework[:score] = hw.score
        homework[:max_score] = quarter_homework.max_score
        homework[:title] = quarter_homework.title
        homework[:date] = format_date(quarter_homework.created_at)
        data[:homeworks] << homework
      end

      @student.exams.each do |ex|
        exam = {}
        quarter_exam = quarter_exams.find(ex.quarter_exam_id)
        exam[:score] = ex.score
        exam[:max_score] = quarter_exam.max_score
        exam[:title] = quarter_exam.title
        exam[:date] = format_date(quarter_exam.created_at)
        data[:exams] << exam
      end

      @student.projects.each do |pj|
        project = {}
        quarter_project = quarter_projects.find(pj.quarter_project_id)
        project[:score] = pj.score
        project[:max_score] = quarter_project.max_score
        project[:title] = quarter_project.title
        project[:date] = format_date(quarter_project.created_at)
        data[:projects] << project
      end

      @student.absents.each do |ab|
        absent = {}
        quarter_attendance = quarter_attendances.find(ab.quarter_attendance_id)
        absent[:date] = quarter_attendance.date
        data[:absents] << absent
      end

      data[:school_days] = quarter_attendances_total
      data[:grades][:seatworks] = calculate(student: student_total_of(data[:seatworks]), quarter: quarter_seatworks_total, requirement: 'seatwork')
      data[:grades][:homeworks] = calculate(student: student_total_of(data[:homeworks]), quarter: quarter_homeworks_total, requirement: 'homework')
      data[:grades][:projects] = calculate(student: student_total_of(data[:projects]), quarter: quarter_projects_total, requirement: 'project')
      data[:grades][:exams] = calculate(student: student_total_of(data[:exams]), quarter: quarter_exams_total, requirement: 'exam')
      data[:grades][:attendance] = calculate(student: (quarter_attendances_total - data[:absents].length).to_f, quarter: quarter_attendances_total, requirement: 'attendance')
      data[:final_grade] = calculate_final(data[:grades])

      data
    end

    def quarter_total_of(resources)
      resources.inject(0) { |sum, resource| sum + resource.max_score }.to_f
    end

    def student_total_of(resources)
      resources.inject(0) { |sum, resource| sum + resource[:score] }.to_f
    end

    def calculate(parameters)
      (((parameters[:student] / parameters[:quarter]) * (@grading_system.send(parameters[:requirement]) * 0.01)) * 100).round(2)
    end

    def calculate_final(data)
      data.values.select { |v| v.is_a?(Float) }.sum.round(2)
    end

    def format_date(date)
      date.to_formatted_s(:short_custom)
    end
  end
end
