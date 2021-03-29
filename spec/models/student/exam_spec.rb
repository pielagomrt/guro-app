require 'rails_helper'

RSpec.describe Student::Exam, type: :model do
  let(:student_exam) { described_class.new }

  before do
    student_exam.score = 20
    student_exam.save
  end

  context 'when saving without exam score' do
    it '1. should not save without exam score' do
      student_exam.score = nil
      student_exam.save
      expect(student_exam).not_to be_valid
    end

    it '2. should only have one error' do
      student_exam.score = nil
      student_exam.save
      expect(student_exam.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for exam score' do
      student_exam.score = nil
      student_exam.save
      expect(student_exam.errors.to_h.keys).to include(:score)
    end
  end
end
