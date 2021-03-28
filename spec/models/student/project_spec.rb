require 'rails_helper'

RSpec.describe Student::Project, type: :model do
  let(:student_project) { described_class.new }

  before do
    student_project.score = 20
    student_project.save
  end

  context 'when saving without project score' do
    it '1. should not save without project score' do
      student_project.score = nil
      student_project.save
      expect(student_project).not_to be_valid
    end

    it '2. should only have one error' do
      student_project.score = nil
      student_project.save
      expect(student_project.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for project score' do
      student_project.score = nil
      student_project.save
      expect(student_project.errors.to_h.keys).to include(:score)
    end
  end
end
