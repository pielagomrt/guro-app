require 'rails_helper'

RSpec.describe FormController, type: :request do
  let(:teacher) { create(:teacher_with_sections) }
  let(:section) { create(:section_with_students) }

  before do
    teacher.confirm
    sign_in(teacher)
  end

  describe 'GET /new/grading-system form#new_grading_system' do
    before { get new_grading_system_form_path }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders new_grading_system template' do
      expect(response).to render_template(:new_grading_system)
    end
  end

  describe 'GET /new/section form#new_section' do
    before { get new_section_form_path }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders new_section template' do
      expect(response).to render_template(:new_section)
    end

    it 'has @grading_systems instance variable' do
      expect(assigns(:grading_systems)).to eq(teacher.grading_systems)
    end
  end

  describe 'GET /new/seatwork/:section_id form#new_seatwork' do
    before { get new_seatwork_form_path(section) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders new_seatwork template' do
      expect(response).to render_template(:new_seatwork)
    end

    it 'has @section instance variable' do
      expect(assigns(:section)).to eq(section)
    end

    it 'has @students instance variable' do
      expect(assigns(:students)).to eq(section.students.order(:last_name))
    end
  end

  describe 'GET /new/homework/:section_id form#new_homework' do
    before { get new_homework_form_path(section) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders new_homework template' do
      expect(response).to render_template(:new_homework)
    end

    it 'has @section instance variable' do
      expect(assigns(:section)).to eq(section)
    end

    it 'has @students instance variable' do
      expect(assigns(:students)).to eq(section.students.order(:last_name))
    end
  end

  describe 'GET /new/project/:section_id form#new_project' do
    before { get new_project_form_path(section) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders new_project template' do
      expect(response).to render_template(:new_project)
    end

    it 'has @section instance variable' do
      expect(assigns(:section)).to eq(section)
    end

    it 'has @students instance variable' do
      expect(assigns(:students)).to eq(section.students.order(:last_name))
    end
  end

  describe 'GET /new/exam/:section_id form#new_exam' do
    before { get new_exam_form_path(section) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders new_exam template' do
      expect(response).to render_template(:new_exam)
    end

    it 'has @section instance variable' do
      expect(assigns(:section)).to eq(section)
    end

    it 'has @students instance variable' do
      expect(assigns(:students)).to eq(section.students.order(:last_name))
    end
  end

  describe 'GET /new/attendance/:section_id form#new_attendance' do
    before { get new_attendance_form_path(section) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders new_attendance template' do
      expect(response).to render_template(:new_attendance)
    end

    it 'has @section instance variable' do
      expect(assigns(:section)).to eq(section)
    end

    it 'has @students instance variable' do
      expect(assigns(:students)).to eq(section.students.order(:last_name))
    end
  end
end
