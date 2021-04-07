require 'rails_helper'

RSpec.describe StudentProcessesController, type: :request do
  let(:teacher) { create(:teacher_with_sections) }
  let(:section) { teacher.sections.first }
  let(:student) { create(:student) }

  before do
    teacher.confirm
    sign_in(teacher)

    student.section = section
    student.seatworks << create(:student_seatwork)
    student.homeworks << create(:student_homework)
    student.projects << create(:student_project)
    student.exams << create(:student_exam)
    student.absents << create(:student_absent)
    student.save
  end

  describe 'PUT /sections/:id/students/:student_id/update student_processes#update_student' do
    let(:updates) { { first_name: 'Lorem', last_name: 'Ipsum', email: 'student@example.com' } }

    before do
      put student_update_path(id: section.id, student_id: student.id), params: { student: updates }
      student.reload
    end

    it 'returns http success' do
      follow_redirect!
      expect(response).to have_http_status(:success)
    end

    it 'updates the student first name' do
      expect(student.first_name).to eq(updates[:first_name])
    end

    it 'updates the student last name' do
      expect(student.last_name).to eq(updates[:last_name])
    end

    it 'updates the student email' do
      expect(student.email).to eq(updates[:email])
    end
  end

  describe 'PUT /sections/:id/students/:student_id/seatworks/:seatwork_id/update student_processes#update_student_seatwork' do
    let(:seatwork) { student.seatworks.first }
    let(:updates) { { score: 70 } }

    before do
      put student_update_seatwork_path(id: section.id, student_id: student.id, seatwork_id: seatwork.id), params: { student_score: updates }
      seatwork.reload
    end

    it 'returns http status 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to path' do
      expect(response).to redirect_to(view_student_seatworks_path(section, student))
    end

    it 'updates the student seatwork score' do
      expect(seatwork.score).to eq(updates[:score])
    end
  end

  describe 'PUT /sections/:id/students/:student_id/homeworks/:homework_id/update student_processes#update_student_homework' do
    let(:homework) { student.homeworks.first }
    let(:updates) { { score: 77 } }

    before do
      put student_update_homework_path(id: section.id, student_id: student.id, homework_id: homework.id), params: { student_score: updates }
      homework.reload
    end

    it 'returns http status 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to path' do
      expect(response).to redirect_to(view_student_homeworks_path(section, student))
    end

    it 'updates the student seatwork score' do
      expect(homework.score).to eq(updates[:score])
    end
  end

  describe 'PUT /sections/:id/students/:student_id/projects/:project_id/update student_processes#update_student_project' do
    let(:project) { student.projects.first }
    let(:updates) { { score: 75 } }

    before do
      put student_update_project_path(id: section.id, student_id: student.id, project_id: project.id), params: { student_score: updates }
      project.reload
    end

    it 'returns http status 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to path' do
      expect(response).to redirect_to(view_student_projects_path(section, student))
    end

    it 'updates the student seatwork score' do
      expect(project.score).to eq(updates[:score])
    end
  end

  describe 'PUT /sections/:id/students/:student_id/exams/:exam_id/update student_processes#update_student_exam' do
    let(:exam) { student.exams.first }
    let(:updates) { { score: 90 } }

    before do
      put student_update_exam_path(id: section.id, student_id: student.id, exam_id: exam.id), params: { student_score: updates }
      exam.reload
    end

    it 'returns http status 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to path' do
      expect(response).to redirect_to(view_student_exams_path(section, student))
    end

    it 'updates the student seatwork score' do
      expect(exam.score).to eq(updates[:score])
    end
  end

  describe 'DELETE /sections/:id/students/:student_id/delete student_processes#destroy_student' do
    before { delete student_delete_path(id: section.id, student_id: student.id) }

    it 'returns http status 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to path' do
      expect(response).to redirect_to(students_path(section))
    end

    it 'deletes the section' do
      expect { Student.find(student.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'DELETE /sections/:id/students/:student_id/seatworks/:seatwork_id/delete student_processes#destroy_student_seatwork' do
    let(:seatwork) { student.seatworks.first }

    before { delete student_delete_seatwork_path(id: section.id, student_id: student.id, seatwork_id: seatwork.id) }

    it 'returns http status 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to path' do
      expect(response).to redirect_to(view_student_seatworks_path(section, student))
    end

    it 'deletes the section' do
      expect { student.seatworks.find(seatwork.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'DELETE /sections/:id/students/:student_id/homeworks/:homework_id/delete student_processes#destroy_student_homework' do
    let(:homework) { student.homeworks.first }

    before { delete student_delete_homework_path(id: section.id, student_id: student.id, homework_id: homework.id) }

    it 'returns http status 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to path' do
      expect(response).to redirect_to(view_student_homeworks_path(section, student))
    end

    it 'deletes the section' do
      expect { student.homeworks.find(homework.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'DELETE /sections/:id/students/:student_id/projects/:project_id/delete student_processes#destroy_student_project' do
    let(:project) { student.projects.first }

    before { delete student_delete_project_path(id: section.id, student_id: student.id, project_id: project.id) }

    it 'returns http status 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to path' do
      expect(response).to redirect_to(view_student_projects_path(section, student))
    end

    it 'deletes the section' do
      expect { student.projects.find(project.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'DELETE /sections/:id/students/:student_id/exams/:exam_id/delete student_processes#destroy_student_exam' do
    let(:exam) { student.exams.first }

    before { delete student_delete_exam_path(id: section.id, student_id: student.id, exam_id: exam.id) }

    it 'returns http status 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to path' do
      expect(response).to redirect_to(view_student_exams_path(section, student))
    end

    it 'deletes the section' do
      expect { student.exams.find(exam.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'DELETE /sections/:id/students/:student_id/absences/:absent_id/delete student_processes#destroy_student_attendance' do
    let(:absent) { student.absents.first }

    before { delete student_delete_attendance_path(id: section.id, student_id: student.id, absent_id: absent.id) }

    it 'returns http status 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to path' do
      expect(response).to redirect_to(view_student_absences_path(section, student))
    end

    it 'deletes the section' do
      expect { student.absents.find(absent.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
