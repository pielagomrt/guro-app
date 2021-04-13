require 'rails_helper'

RSpec.describe SectionsController, type: :request do
  let(:teacher) { create(:teacher_with_sections) }
  let(:section) { teacher.sections.first }
  let(:current_quarter) { section.quarters.find_by(sequence: section.active_quarter) }

  before do
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
  end

  describe 'GET /sections sections#index' do
    before { get sections_path }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
    end

    it 'has @sections instance variable' do
      expect(assigns(:sections)).to eq(teacher.sections)
    end
  end

  describe 'GET /section/:id sections#show' do
    before { get section_path(section) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders show template' do
      expect(response).to render_template(:show)
    end

    it 'has @section instance variable' do
      expect(assigns(:section)).to eq(section)
    end
  end

  describe 'GET /section/:id/seatworks sections#view_seatworks' do
    before { get view_section_seatworks_path(section) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders view_seatworks template' do
      expect(response).to render_template(:view_seatworks)
    end

    it 'has @seatworks instance variable' do
      expect(assigns(:seatworks)).to eq(current_quarter.seatworks)
    end
  end

  describe 'GET /section/:id/homeworks sections#view_homeworks' do
    before { get view_section_homeworks_path(section) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders view_homeworks template' do
      expect(response).to render_template(:view_homeworks)
    end

    it 'has @homeworks instance variable' do
      expect(assigns(:homeworks)).to eq(current_quarter.homeworks)
    end
  end

  describe 'GET /section/:id/projects sections#view_projects' do
    before { get view_section_projects_path(section) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders view_projects template' do
      expect(response).to render_template(:view_projects)
    end

    it 'has @projects instance variable' do
      expect(assigns(:projects)).to eq(current_quarter.projects)
    end
  end

  describe 'GET /section/:id/exams sections#view_exams' do
    before { get view_section_exams_path(section) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders view_exams template' do
      expect(response).to render_template(:view_exams)
    end

    it 'has @exams instance variable' do
      expect(assigns(:exams)).to eq(current_quarter.exams)
    end
  end

  describe 'GET /section/:id/attendances sections#view_attendances' do
    before { get view_section_attendances_path(section) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders view_attendances template' do
      expect(response).to render_template(:view_attendances)
    end

    it 'has @attendances instance variable' do
      expect(assigns(:attendances)).to eq(current_quarter.attendances)
    end

    it 'has @absences instance variable' do
      absences = {}
      current_quarter.attendances.each { |attendance| absences[attendance.id] = attendance.student_absents.length }
      expect(assigns(:absences)).to eq(absences)
    end
  end
end
