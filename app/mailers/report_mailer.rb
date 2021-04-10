class ReportMailer < ApplicationMailer
  def section_summary
    report = ::Reports::Section.new(params[:section])
    path_to_pdf = report.to_pdf_to_tmp

    attachments["section_report_for_#{report.section.name}.pdf"] = File.read(path_to_pdf)

    mail(to: params[:teacher].email, subject: "Section Summary for #{report.section.name}") do |format|
      format.html { render 'report_mailer/message' }
    end
  end

  def student_summary
    report = ::Reports::Student.new(params[:student])
    path_to_pdf = report.to_pdf_to_tmp

    attachments["student_report_for_#{report.student.first_name}_#{report.student.last_name}.pdf"] = File.read(path_to_pdf)

    mail(to: report.student.email, subject: "Student Summary for #{report.student.last_name}, #{report.student.first_name}") do |format|
      format.html { render 'report_mailer/message' }
    end
  end
end
