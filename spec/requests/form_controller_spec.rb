require 'rails_helper'

RSpec.describe FormController, type: :request do
  let(:section) { create(:section_with_students) }

  describe 'GET /new/section form#new_section' do
    it 'returns http success' do
      get new_section_form_path
      expect(response).to have_http_status(:success)
    end

    it 'renders new_section template' do
      get new_section_form_path
      expect(response).to render_template(:new_section)
    end
  end

  describe 'GET /new/seatwork/:section_id form#new_seatwork' do
    it 'returns http success' do
      get new_seatwork_form_path(section)
      expect(response).to have_http_status(:success)
    end

    it 'renders new_seatwork template' do
      get new_seatwork_form_path(section)
      expect(response).to render_template(:new_seatwork)
    end

    it 'has @students instance variable' do
      get new_seatwork_form_path(section)
      expect(assigns(:students)).to eq(section.students)
    end
  end

  describe 'GET /new/homework/:section_id form#new_homework' do
    it 'returns http success' do
      get new_homework_form_path(section)
      expect(response).to have_http_status(:success)
    end

    it 'renders new_homework template' do
      get new_homework_form_path(section)
      expect(response).to render_template(:new_homework)
    end

    it 'has @students instance variable' do
      get new_homework_form_path(section)
      expect(assigns(:students)).to eq(section.students)
    end
  end

  describe 'GET /new/project/:section_id form#new_project' do
    it 'returns http success' do
      get new_project_form_path(section)
      expect(response).to have_http_status(:success)
    end

    it 'renders new_project template' do
      get new_project_form_path(section)
      expect(response).to render_template(:new_project)
    end

    it 'has @students instance variable' do
      get new_project_form_path(section)
      expect(assigns(:students)).to eq(section.students)
    end
  end

  describe 'GET /new/exam/:section_id form#new_exam' do
    it 'returns http success' do
      get new_exam_form_path(section)
      expect(response).to have_http_status(:success)
    end

    it 'renders new_exam template' do
      get new_exam_form_path(section)
      expect(response).to render_template(:new_exam)
    end

    it 'has @students instance variable' do
      get new_exam_form_path(section)
      expect(assigns(:students)).to eq(section.students)
    end
  end

  describe 'GET /new/attendance/:section_id form#new_attendance' do
    it 'returns http success' do
      get new_attendance_form_path(section)
      expect(response).to have_http_status(:success)
    end

    it 'renders new_attendance template' do
      get new_attendance_form_path(section)
      expect(response).to render_template(:new_attendance)
    end

    it 'has @students instance variable' do
      get new_attendance_form_path(section)
      expect(assigns(:students)).to eq(section.students)
    end
  end
end
