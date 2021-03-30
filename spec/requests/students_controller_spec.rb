require 'rails_helper'

RSpec.describe StudentsController, type: :request do
  let(:student) { create(:student) }

  describe 'GET / students#index' do
    it 'returns http success' do
      get students_path
      expect(response).to have_http_status(:success)
    end

    it 'renders index template' do
      get students_path
      expect(response).to render_template(:index)
    end

    it 'has @students instance variable' do
      get students_path
      expect(assigns(:students)).to eq(Student.all)
    end
  end

  describe 'GET / students#show' do
    it 'returns http success' do
      get student_path(student)
      expect(response).to have_http_status(:success)
    end

    it 'renders show template' do
      get student_path(student)
      expect(response).to render_template(:show)
    end

    it 'has @student instance variable' do
      get student_path(student)
      expect(assigns(:student)).to eq(Student.find(student.id))
    end
  end

  describe 'GET / students#view_seatworks' do
    it 'returns http success' do
      get view_student_seatworks_path(student)
      expect(response).to have_http_status(:success)
    end

    it 'renders view_seatworks template' do
      get view_student_seatworks_path(student)
      expect(response).to render_template(:view_seatworks)
    end

    it 'has @student_seatworks instance variable' do
      get view_student_seatworks_path(student)
      expect(assigns(:student_seatworks)).to eq(student.seatworks)
    end
  end

  describe 'GET / students#view_homeworks' do
    it 'returns http success' do
      get view_student_homeworks_path(student)
      expect(response).to have_http_status(:success)
    end

    it 'renders view_homeworks template' do
      get view_student_homeworks_path(student)
      expect(response).to render_template(:view_homeworks)
    end

    it 'has @student_homeworks instance variable' do
      get view_student_homeworks_path(student)
      expect(assigns(:student_homeworks)).to eq(student.homeworks)
    end
  end

  describe 'GET / students#view_projects' do
    it 'returns http success' do
      get view_student_projects_path(student)
      expect(response).to have_http_status(:success)
    end

    it 'renders view_projects template' do
      get view_student_projects_path(student)
      expect(response).to render_template(:view_projects)
    end

    it 'has @student_projects instance variable' do
      get view_student_projects_path(student)
      expect(assigns(:student_projects)).to eq(student.projects)
    end
  end

  describe 'GET / students#view_exams' do
    it 'returns http success' do
      get view_student_exams_path(student)
      expect(response).to have_http_status(:success)
    end

    it 'renders view_exams template' do
      get view_student_exams_path(student)
      expect(response).to render_template(:view_exams)
    end

    it 'has @student_exams instance variable' do
      get view_student_exams_path(student)
      expect(assigns(:student_exams)).to eq(student.exams)
    end
  end

  describe 'GET / students#view_absences' do
    it 'returns http success' do
      get view_student_absences_path(student)
      expect(response).to have_http_status(:success)
    end

    it 'renders view_absences template' do
      get view_student_absences_path(student)
      expect(response).to render_template(:view_absences)
    end

    it 'has @student_absents instance variable' do
      get view_student_absences_path(student)
      expect(assigns(:student_absents)).to eq(student.absents)
    end
  end
end
