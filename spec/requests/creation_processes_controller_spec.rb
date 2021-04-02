require 'rails_helper'

RSpec.describe CreationProcessesController, type: :request do
  let(:teacher) { create(:teacher_with_sections) }
  let(:section) { teacher.sections.first }
  let(:current_quarter) { section.quarters[-section.active_quarter] }

  before do
    teacher.confirm
    sign_in(teacher)

    teacher.grading_systems << create(:grading_system)
    teacher.save

    section.quarters << create(:quarter)
    section.students << create(:student)
    section.students << create(:student)
    section.students << create(:student)
    section.save
  end

  describe 'POST new/section creation_processes#create_section' do
    let(:section_attributes) { attributes_for(:section) }
    let(:students) { {} }

    before do
      3.times { |i| students[i] = attributes_for(:student) }
      post create_section_path, params: {
        details: section_attributes,
        section_students: { students: students },
        grading_system: teacher.grading_systems.first.id
      }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'adds a section' do
      expect(Section.find_by(name: section_attributes[:name]).name).to eq(section_attributes[:name])
    end

    it 'adds 3 students' do
      expect(Student.all.length).to eq(6) # including the 3 students created on global before do block
    end
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

    it 'adds 1 new quarter seatwork' do
      expect(Quarter::Seatwork.all.length).to eq(1)
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

    it 'adds 1 new quarter homework' do
      expect(Quarter::Homework.all.length).to eq(1)
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

    it 'adds 1 new quarter project' do
      expect(Quarter::Project.all.length).to eq(1)
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

    it 'adds 1 new quarter exam' do
      expect(Quarter::Exam.all.length).to eq(1)
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

    it 'adds 1 new quarter attendance' do
      expect(Quarter::Attendance.all.length).to eq(1)
    end

    it 'adds absent to student' do
      expect(Date.parse(absent[:date])).to eq(Quarter::Attendance.find_by(date: absent[:date]).date)
    end
  end
end
