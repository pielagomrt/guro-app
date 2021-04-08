require 'rails_helper'

RSpec.describe SectionProcessesController, type: :request do
  let(:teacher) { create(:teacher_with_sections) }
  let(:section) { teacher.sections.first }
  let(:current_quarter) { section.quarters.find_by(sequence: section.active_quarter) }

  before do
    teacher.confirm
    sign_in(teacher)

    section.quarters << create(:quarter)
    section.students << create(:student)
    section.students << create(:student)
    section.save

    current_quarter.seatworks << create(:quarter_seatwork)
    current_quarter.homeworks << create(:quarter_homework)
    current_quarter.projects << create(:quarter_project)
    current_quarter.exams << create(:quarter_exam)
    current_quarter.attendances << create(:quarter_attendance)
    current_quarter.save
  end

  describe 'PUT /sections/:id/update sections#update_section' do
    let(:updates) { { name: 'New Section Name', active_quarter: 2 } }

    before do
      put section_update_path(section), params: { section: updates }
      section.reload
    end

    it 'returns http success' do
      follow_redirect!
      expect(response).to have_http_status(:success)
    end

    it 'updates the section name' do
      expect(section.name).to eq(updates[:name])
    end

    it 'updates the section active quarter' do
      expect(section.active_quarter).to eq(updates[:active_quarter])
    end
  end

  describe 'PUT /sections/:id/seatworks/:seatwork_id sections#update_section_seatwork' do
    let(:seatwork) { current_quarter.seatworks.first }
    let(:updates) { { title: 'New Seatwork Title', max_score: 200 } }

    before do
      put section_seatwork_update_path(id: section.id, seatwork_id: seatwork.id), params: { quarter: updates }
      seatwork.reload
    end

    it 'returns http status 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to path' do
      expect(response).to redirect_to(view_section_seatworks_path(section))
    end

    it 'updates the seatwork title' do
      expect(seatwork.title).to eq(updates[:title])
    end

    it 'updates the seatwork max_score' do
      expect(seatwork.max_score).to eq(updates[:max_score])
    end
  end

  describe 'PUT /sections/:id/homeworks/:homework_id sections#update_section_homework' do
    let(:homework) { current_quarter.homeworks.first }
    let(:updates) { { title: 'New Homework Title', max_score: 200 } }

    before do
      put section_homework_update_path(id: section.id, homework_id: homework.id), params: { quarter: updates }
      homework.reload
    end

    it 'returns http status 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to path' do
      expect(response).to redirect_to(view_section_homeworks_path(section))
    end

    it 'updates the homework title' do
      expect(homework.title).to eq(updates[:title])
    end

    it 'updates the homework max_score' do
      expect(homework.max_score).to eq(updates[:max_score])
    end
  end

  describe 'PUT /sections/:id/projects/:project_id sections#update_section_project' do
    let(:project) { current_quarter.projects.first }
    let(:updates) { { title: 'New Project Title', max_score: 200 } }

    before do
      put section_project_update_path(id: section.id, project_id: project.id), params: { quarter: updates }
      project.reload
    end

    it 'returns http status 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to path' do
      expect(response).to redirect_to(view_section_projects_path(section))
    end

    it 'updates the project title' do
      expect(project.title).to eq(updates[:title])
    end

    it 'updates the project max_score' do
      expect(project.max_score).to eq(updates[:max_score])
    end
  end

  describe 'PUT /sections/:id/exams/:exam_id sections#update_section_exam' do
    let(:exam) { current_quarter.exams.first }
    let(:updates) { { title: 'New Exam Title', max_score: 200 } }

    before do
      put section_exam_update_path(id: section.id, exam_id: exam.id), params: { quarter: updates }
      exam.reload
    end

    it 'returns http status 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to path' do
      expect(response).to redirect_to(view_section_exams_path(section))
    end

    it 'updates the exam title' do
      expect(exam.title).to eq(updates[:title])
    end

    it 'updates the exam max_score' do
      expect(exam.max_score).to eq(updates[:max_score])
    end
  end

  describe 'PUT /sections/:id/attendances/:attendance_id sections#update_section_attendance' do
    let(:attendance) { current_quarter.attendances.first }
    let(:updates) { { date: '2050-02-25' } }

    before do
      put section_attendance_update_path(id: section.id, attendance_id: attendance.id), params: { quarter: updates }
      attendance.reload
    end

    it 'returns http status 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to path' do
      expect(response).to redirect_to(view_section_attendances_path(section))
    end

    it 'updates the attendance date' do
      expect(attendance.date).to eq(Date.parse(updates[:date]))
    end
  end

  describe 'DELETE /sections/:id/delete sections#destroy_section' do
    before { delete section_delete_path(section) }

    it 'returns http status 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to path' do
      expect(response).to redirect_to(dashboard_path)
    end

    it 'deletes the section' do
      expect { Section.find(section.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'DELETE /sections/:id/seatwork/:seatwork_id sections#destroy_section_seatwork' do
    let(:seatwork) { current_quarter.seatworks.first }

    before { delete section_seatwork_delete_path(id: section.id, seatwork_id: seatwork.id) }

    it 'returns http status 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to path' do
      expect(response).to redirect_to(view_section_seatworks_path(section))
    end

    it 'deletes the section' do
      expect { current_quarter.seatworks.find(seatwork.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'DELETE /sections/:id/homework/:homework_id sections#destroy_section_homework' do
    let(:homework) { current_quarter.homeworks.first }

    before { delete section_homework_delete_path(id: section.id, homework_id: homework.id) }

    it 'returns http status 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to path' do
      expect(response).to redirect_to(view_section_homeworks_path(section))
    end

    it 'deletes the homework' do
      expect { current_quarter.homeworks.find(homework.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'DELETE /sections/:id/projects/:project_id sections#destroy_section_project' do
    let(:project) { current_quarter.projects.first }

    before { delete section_project_delete_path(id: section.id, project_id: project.id) }

    it 'returns http status 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to path' do
      expect(response).to redirect_to(view_section_projects_path(section))
    end

    it 'deletes the project' do
      expect { current_quarter.projects.find(project.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'DELETE /sections/:id/exams/:exam_id sections#destroy_section_exam' do
    let(:exam) { current_quarter.exams.first }

    before { delete section_exam_delete_path(id: section.id, exam_id: exam.id) }

    it 'returns http status 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to path' do
      expect(response).to redirect_to(view_section_exams_path(section))
    end

    it 'deletes the exam' do
      expect { current_quarter.exams.find(exam.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'DELETE /sections/:id/attendances/:attendance_id sections#destroy_section_attendance' do
    let(:attendance) { current_quarter.attendances.first }

    before { delete section_attendance_delete_path(id: section.id, attendance_id: attendance.id) }

    it 'returns http status 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to path' do
      expect(response).to redirect_to(view_section_attendances_path(section))
    end

    it 'deletes the attendance' do
      expect { current_quarter.attendances.find(attendance.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
