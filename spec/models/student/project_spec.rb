require 'rails_helper'

RSpec.describe Student::Project, type: :model do
  let(:student_project) { described_class.new }

  before do
    student_project.score = 20
    student_project.student = create(:student)
    student_project.quarter = create(:quarter)
    student_project.quarter_project = create(:quarter_project)
    student_project.save
  end

  context 'when saving without project score' do
    before do
      student_project.score = nil
      student_project.save
    end

    it '1. should not save without project score' do
      expect(student_project).not_to be_valid
    end

    it '2. should only have one error' do
      expect(student_project.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for project score' do
      expect(student_project.errors.to_h.keys).to include(:score)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:student) }
    it { is_expected.to belong_to(:quarter) }
    it { is_expected.to belong_to(:quarter_project) }
  end
end
