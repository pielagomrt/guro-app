require 'rails_helper'

RSpec.describe SectionsController, type: :request do
  let(:teacher) { create(:teacher_with_sections) }
  let(:section) { teacher.sections.first }
  let(:current_quarter) { section.quarters[-section.active_quarter] }

  before do
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
  end

  describe 'GET /sections sections#index' do
    it 'returns http success' do
      get sections_path
      expect(response).to have_http_status(:success)
    end

    it 'renders index template' do
      get sections_path
      expect(response).to render_template(:index)
    end

    it 'has @sections instance variable' do
      get sections_path
      expect(assigns(:sections)).to eq(teacher.sections)
    end
  end

  describe 'GET /section/:id sections#show' do
    let(:section) { teacher.sections.first }

    it 'returns http success' do
      get section_path(section)
      expect(response).to have_http_status(:success)
    end

    it 'renders show template' do
      get section_path(section)
      expect(response).to render_template(:show)
    end

    it 'has @section instance variable' do
      get section_path(section)
      expect(assigns(:section)).to eq(section)
    end
  end

  describe 'GET /section/:id/seatworks sections#view_seatworks' do
    it 'returns http success' do
      get view_section_seatworks_path(section)
      expect(response).to have_http_status(:success)
    end

    it 'renders view_seatworks template' do
      get view_section_seatworks_path(section)
      expect(response).to render_template(:view_seatworks)
    end

    it 'has @seatworks instance variable' do
      get view_section_seatworks_path(section)
      expect(assigns(:seatworks)).to eq(current_quarter.seatworks)
    end
  end

  describe 'GET /section/:id/homeworks sections#view_homeworks' do
    it 'returns http success' do
      get view_section_homeworks_path(section)
      expect(response).to have_http_status(:success)
    end

    it 'renders view_homeworks template' do
      get view_section_homeworks_path(section)
      expect(response).to render_template(:view_homeworks)
    end

    it 'has @homeworks instance variable' do
      get view_section_homeworks_path(section)
      expect(assigns(:homeworks)).to eq(current_quarter.homeworks)
    end
  end

  describe 'GET /section/:id/projects sections#view_projects' do
    it 'returns http success' do
      get view_section_projects_path(section)
      expect(response).to have_http_status(:success)
    end

    it 'renders view_projects template' do
      get view_section_projects_path(section)
      expect(response).to render_template(:view_projects)
    end

    it 'has @projects instance variable' do
      get view_section_projects_path(section)
      expect(assigns(:projects)).to eq(current_quarter.projects)
    end
  end

  describe 'GET /section/:id/exams sections#view_exams' do
    it 'returns http success' do
      get view_section_exams_path(section)
      expect(response).to have_http_status(:success)
    end

    it 'renders view_exams template' do
      get view_section_exams_path(section)
      expect(response).to render_template(:view_exams)
    end

    it 'has @exams instance variable' do
      get view_section_exams_path(section)
      expect(assigns(:exams)).to eq(current_quarter.exams)
    end
  end

  describe 'GET /section/:id/attendances sections#view_attendances' do
    it 'returns http success' do
      get view_section_attendances_path(section)
      expect(response).to have_http_status(:success)
    end

    it 'renders view_attendances template' do
      get view_section_attendances_path(section)
      expect(response).to render_template(:view_attendances)
    end

    it 'has @attendances instance variable' do
      get view_section_attendances_path(section)
      expect(assigns(:attendances)).to eq(current_quarter.attendances)
    end
  end
end
