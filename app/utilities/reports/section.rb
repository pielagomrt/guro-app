module Reports
  class Section
    attr_reader :section

    def initialize(section)
      @section = section
      @grading_system = @section.grading_system
      @active_quarter = @section.quarters.find_by(sequence: @section.active_quarter)
    end

    def to_html
      ApplicationController.renderer.render('report_mailer/section_summary', assigns: { data: section_data }, layout: false)
    end

    def to_pdf
      WickedPdf.new.pdf_from_string(to_html, page_size: 'A4', orientation: 'Landscape')
    end

    def to_pdf_to_tmp
      pdf_file_path = "tmp/#{@section.name}_#{Time.zone.now.nsec}.pdf"
      pdf_file = File.new(pdf_file_path, 'w')
      pdf_file.write(to_pdf.force_encoding('UTF-8'))
      pdf_file.close
      pdf_file_path
    end

    private

    def section_data
      data = { section: @section, teacher: @section.teacher, grading_system: @grading_system, students: [] }

      quarter_seatwork_total = quarter_total_of(@active_quarter.seatworks)
      quarter_homework_total = quarter_total_of(@active_quarter.homeworks)
      quarter_project_total = quarter_total_of(@active_quarter.projects)
      quarter_exam_total = quarter_total_of(@active_quarter.exams)
      quarter_attendance_total = @active_quarter.attendances.length.to_f

      @section.students.order(:last_name).each do |student|
        student_data = {}
        student_data[:first_name] = student.first_name
        student_data[:last_name] = student.last_name

        total_sw_score = student_total_of(student.seatworks.where(quarter_id: @active_quarter.id))
        total_hw_score = student_total_of(student.homeworks.where(quarter_id: @active_quarter.id))
        total_pj_score = student_total_of(student.projects.where(quarter_id: @active_quarter.id))
        total_ex_score = student_total_of(student.exams.where(quarter_id: @active_quarter.id))
        total_at_score = (quarter_attendance_total - student.absents.where(quarter_id: @active_quarter.id).length).to_f

        student_data[:seatworks] = calculate(student: total_sw_score, quarter: quarter_seatwork_total, requirement: 'seatwork')
        student_data[:homeworks] = calculate(student: total_hw_score, quarter: quarter_homework_total, requirement: 'homework')
        student_data[:projects] = calculate(student: total_pj_score, quarter: quarter_project_total, requirement: 'project')
        student_data[:exams] = calculate(student: total_ex_score, quarter: quarter_exam_total, requirement: 'exam')
        student_data[:attendance] = calculate(student: total_at_score, quarter: quarter_attendance_total, requirement: 'attendance')
        student_data[:final_grade] = calculate_final(student_data)

        data[:students] << student_data
      end
      data
    end

    def quarter_total_of(resources)
      resources.inject(0) { |sum, resource| sum + resource.max_score }.to_f
    end

    def student_total_of(resources)
      resources.inject(0) { |sum, resource| sum + resource.score }.to_f
    end

    def calculate(parameters)
      (((parameters[:student] / parameters[:quarter]) * (@grading_system.send(parameters[:requirement]) * 0.01)) * 100).round(2)
    end

    def calculate_final(data)
      data.values.select { |v| v.is_a?(Float) }.sum.round(2)
    end
  end
end
