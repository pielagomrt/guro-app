class DashboardController < ApplicationController
  before_action :authenticate_teacher!, except: [:root]

  def root
    render layout: 'landing'
  end

  def dashboard
    @youtube_videos = Youtube.search(current_teacher.subject)

    @students = []
    section.each { |section| @students << section.students.group(:section_id).count.values }
    @student_count = @students.map(&:sum)

    @seatworks = []
    @homeworks = []
    @projects = []
    @exams = []
    section_quarters.each do |category|
      @seatworks << Quarter::Seatwork.where(quarter_id: category[:id]).count
      @homeworks << Quarter::Homework.where(quarter_id: category[:id]).count
      @projects << Quarter::Project.where(quarter_id: category[:id]).count
      @exams << Quarter::Exam.where(quarter_id: category[:id]).count
    end
  end

  private

  def section
    @sections = current_teacher.sections
  end

  def section_quarters
    @quarters = []
    section.each { |section| @quarters << section.quarters }
    @section_quarters = @quarters.flatten
  end
end
