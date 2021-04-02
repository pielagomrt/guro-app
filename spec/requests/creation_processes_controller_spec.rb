require 'rails_helper'

RSpec.describe CreationProcessesController, type: :request do
  let(:teacher) { create(:teacher_with_sections) }
  let(:section) { teacher.sections.first }
  let(:current_quarter) { section.quarters[-section.active_quarter] }

  before do
    teacher.confirm
    sign_in(teacher)

    section.quarters << create(:quarter)
    section.students << create(:student)
    section.students << create(:student)
    section.students << create(:student)
    section.save

    current_quarter.attendances << create(:quarter_attendance)
    current_quarter.save
  end

  describe 'POST new/seatwork/:section_id creation_processes#create_seatwork' do
    let(:seatwork) { attributes_for(:quarter_seatwork) }
    let(:students) { {} }

    before do
      section.students.each { |student| students[student.id] = { score: 25 } }
      post create_seatwork_path(section_id: section.id), params: {
        details: seatwork,
        section_students: { students: students }
      }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'adds 3 new student seatwork' do
      expect(students.length).to eq(Student::Seatwork.all.length)
    end
  end

  describe 'POST new/homework/:section_id creation_processes#create_homework' do
    let(:homework) { attributes_for(:quarter_homework) }
    let(:students) { {} }

    before do
      section.students.each { |student| students[student.id] = { score: 25 } }
      post create_homework_path(section_id: section.id), params: {
        details: homework,
        section_students: { students: students }
      }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'adds 3 new student homework' do
      expect(students.length).to eq(Student::Homework.all.length)
    end
  end

  describe 'POST new/project/:section_id creation_processes#create_project' do
    let(:project) { attributes_for(:quarter_project) }
    let(:students) { {} }

    before do
      section.students.each { |student| students[student.id] = { score: 25 } }
      post create_project_path(section_id: section.id), params: {
        details: project,
        section_students: { students: students }
      }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'adds 3 new student projects' do
      expect(students.length).to eq(Student::Project.all.length)
    end
  end

  describe 'POST new/exam/:section_id creation_processes#create_exam' do
    let(:exam) { attributes_for(:quarter_exam) }
    let(:students) { {} }

    before do
      section.students.each { |student| students[student.id] = { score: 25 } }
      post create_exam_path(section_id: section.id), params: {
        details: exam,
        section_students: { students: students }
      }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'adds 3 new student exams' do
      expect(students.length).to eq(Student::Exam.all.length)
    end
  end

  describe 'POST new/absent/:section_id creation_processes#create_absent' do
    let(:absent) { attributes_for(:quarter_attendance) }
    let(:student) { section.students.first }

    before do
      post create_absent_path(section_id: section.id), params: {
        student_id: student.id,
        attendance: absent
      }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'adds absent to student' do
      expect(absent[:date]).to eq(Quarter::Attendance.find_by(id: current_quarter.attendances.first)[:date].to_s)
    end
  end
end
