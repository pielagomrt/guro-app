require 'rails_helper'

RSpec.describe StudentsController, type: :request do
  let(:teacher) { create(:teacher_with_sections) }
  let(:student) { create(:student) }
  let(:section) { teacher.sections.first }
  let(:current_quarter) { section.quarters.find_by(sequence: section.active_quarter) }

  before do
    Faker::Internet.unique.clear

    teacher.confirm
    sign_in(teacher)

    section.quarters << create(:quarter)
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
    before { get students_path(section) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
    end

    it 'has @students instance variable' do
      expect(assigns(:students)).to eq(section.students)
    end
  end

  describe 'GET /sections/:id/students/:student_id students#show' do
    before { get student_path(id: section.id, student_id: student.id) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders show template' do
      expect(response).to render_template(:show)
    end

    it 'has @student instance variable' do
      expect(assigns(:student)).to eq(Student.find_by(id: student.id, section_id: section.id))
    end
  end

  describe 'GET /sections/:id/students/:student_id/seatworks students#view_seatworks' do
    before { get view_student_seatworks_path(id: section.id, student_id: student.id) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders view_seatworks template' do
      expect(response).to render_template(:view_seatworks)
    end

    it 'has @student_seatworks instance variable' do
      expect(assigns(:student_seatworks)).to eq(student.seatworks.where(quarter_id: current_quarter.id))
    end
  end

  describe 'GET /sections/:id/students/:student_id/homeworks students#view_homeworks' do
    before { get view_student_homeworks_path(id: section.id, student_id: student.id) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders view_homeworks template' do
      expect(response).to render_template(:view_homeworks)
    end

    it 'has @student_homeworks instance variable' do
      expect(assigns(:student_homeworks)).to eq(student.homeworks.where(quarter_id: current_quarter.id))
    end
  end

  describe 'GET /sections/:id/students/:student_id/projects students#view_projects' do
    before { get view_student_projects_path(id: section.id, student_id: student.id) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders view_projects template' do
      expect(response).to render_template(:view_projects)
    end

    it 'has @student_projects instance variable' do
      expect(assigns(:student_projects)).to eq(student.projects.where(quarter_id: current_quarter.id))
    end
  end

  describe 'GET /sections/:id/students/:student_id/exams students#view_exams' do
    before { get view_student_exams_path(id: section.id, student_id: student.id) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders view_exams template' do
      expect(response).to render_template(:view_exams)
    end

    it 'has @student_exams instance variable' do
      expect(assigns(:student_exams)).to eq(student.exams.where(quarter_id: current_quarter.id))
    end
  end

  describe 'GET /sections/:id/students/:student_id/attendance students#view_absences' do
    before { get view_student_absences_path(id: section.id, student_id: student.id) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders view_absences template' do
      expect(response).to render_template(:view_absences)
    end

    it 'has @student_absents instance variable' do
      expect(assigns(:student_absents)).to eq(student.absents.where(quarter_id: current_quarter.id))
    end
  end
end
