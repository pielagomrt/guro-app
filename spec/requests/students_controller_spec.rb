require 'rails_helper'

RSpec.describe StudentsController, type: :request do
  let(:teacher) { create(:teacher_with_sections) }
  let(:student) { create(:student) }
  let(:section) { teacher.sections.first }
  let(:current_quarter) { section.quarters[-section.active_quarter] }

  before do
    Faker::Internet.unique.clear

    teacher.confirm
    sign_in(teacher)

    section.quarters << Quarter.new(school_year: '2021-2022', sequence: 1, max_attendance: 50)
    section.quarters << Quarter.new(school_year: '2021-2022', sequence: 2, max_attendance: 50)
    section.save

    current_quarter.seatworks << create(:quarter_seatwork)
    current_quarter.homeworks << create(:quarter_homework)
    current_quarter.projects << create(:quarter_project)
    current_quarter.exams << create(:quarter_exam)
    current_quarter.attendances << create(:quarter_attendance)
    current_quarter.save

    homework = create(:student_homework)
    homework.quarter = current_quarter
    homework.quarter_homework = current_quarter.homeworks.first
    homework.save

    seatwork = create(:student_seatwork)
    seatwork.quarter = current_quarter
    seatwork.quarter_seatwork = current_quarter.seatworks.first
    seatwork.save

    project = create(:student_project)
    project.quarter = current_quarter
    project.quarter_project = current_quarter.projects.first
    project.save

    exam = create(:student_exam)
    exam.quarter = current_quarter
    exam.quarter_exam = current_quarter.exams.first
    exam.save

    absent = create(:student_absent)
    absent.quarter = current_quarter
    absent.quarter_attendance = current_quarter.attendances.first
    absent.save

    student.homeworks << homework
    student.seatworks << seatwork
    student.projects << project
    student.exams << exam
    student.absents << absent
    student.section = section
    student.save
  end

  describe 'GET /sections/:id/students students#index' do
    it 'returns http success' do
      get students_path(section)
      expect(response).to have_http_status(:success)
    end

    it 'renders index template' do
      get students_path(section)
      expect(response).to render_template(:index)
    end

    it 'has @students instance variable' do
      get students_path(section)
      expect(assigns(:students)).to eq(section.students)
    end
  end

  describe 'GET /sections/:id/students/:student_id students#show' do
    it 'returns http success' do
      get student_path(id: section.id, student_id: student.id)
      expect(response).to have_http_status(:success)
    end

    it 'renders show template' do
      get student_path(id: section.id, student_id: student.id)
      expect(response).to render_template(:show)
    end

    it 'has @student instance variable' do
      get student_path(id: section.id, student_id: student.id)
      expect(assigns(:student)).to eq(Student.find_by(id: student.id, section_id: section.id))
    end
  end

  describe 'GET /sections/:id/students/:student_id/seatworks students#view_seatworks' do
    it 'returns http success' do
      get view_student_seatworks_path(id: section.id, student_id: student.id)
      expect(response).to have_http_status(:success)
    end

    it 'renders view_seatworks template' do
      get view_student_seatworks_path(id: section.id, student_id: student.id)
      expect(response).to render_template(:view_seatworks)
    end

    it 'has @student_seatworks instance variable' do
      get view_student_seatworks_path(id: section.id, student_id: student.id)
      expect(assigns(:student_seatworks)).to eq(student.seatworks.where(quarter_id: current_quarter.id))
    end
  end

  describe 'GET /sections/:id/students/:student_id/homeworks students#view_homeworks' do
    it 'returns http success' do
      get view_student_homeworks_path(id: section.id, student_id: student.id)
      expect(response).to have_http_status(:success)
    end

    it 'renders view_homeworks template' do
      get view_student_homeworks_path(id: section.id, student_id: student.id)
      expect(response).to render_template(:view_homeworks)
    end

    it 'has @student_homeworks instance variable' do
      get view_student_homeworks_path(id: section.id, student_id: student.id)
      expect(assigns(:student_homeworks)).to eq(student.homeworks.where(quarter_id: current_quarter.id))
    end
  end

  describe 'GET /sections/:id/students/:student_id/projects students#view_projects' do
    it 'returns http success' do
      get view_student_projects_path(id: section.id, student_id: student.id)
      expect(response).to have_http_status(:success)
    end

    it 'renders view_projects template' do
      get view_student_projects_path(id: section.id, student_id: student.id)
      expect(response).to render_template(:view_projects)
    end

    it 'has @student_projects instance variable' do
      get view_student_projects_path(id: section.id, student_id: student.id)
      expect(assigns(:student_projects)).to eq(student.projects.where(quarter_id: current_quarter.id))
    end
  end

  describe 'GET /sections/:id/students/:student_id/exams students#view_exams' do
    it 'returns http success' do
      get view_student_exams_path(id: section.id, student_id: student.id)
      expect(response).to have_http_status(:success)
    end

    it 'renders view_exams template' do
      get view_student_exams_path(id: section.id, student_id: student.id)
      expect(response).to render_template(:view_exams)
    end

    it 'has @student_exams instance variable' do
      get view_student_exams_path(id: section.id, student_id: student.id)
      expect(assigns(:student_exams)).to eq(student.exams.where(quarter_id: current_quarter.id))
    end
  end

  describe 'GET /sections/:id/students/:student_id/attendance students#view_absences' do
    it 'returns http success' do
      get view_student_absences_path(id: section.id, student_id: student.id)
      expect(response).to have_http_status(:success)
    end

    it 'renders view_absences template' do
      get view_student_absences_path(id: section.id, student_id: student.id)
      expect(response).to render_template(:view_absences)
    end

    it 'has @student_absents instance variable' do
      get view_student_absences_path(id: section.id, student_id: student.id)
      expect(assigns(:student_absents)).to eq(student.absents.where(quarter_id: current_quarter.id))
    end
  end
end
