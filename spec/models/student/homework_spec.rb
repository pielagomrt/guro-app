require 'rails_helper'

RSpec.describe Student::Homework, type: :model do
  let(:student_homework) { described_class.new }

  before do
    student_homework.score = 20
    student_homework.student = create(:student)
    student_homework.quarter = create(:quarter)
    student_homework.quarter_homework = create(:quarter_homework)
    student_homework.save
  end

  context 'when saving without homework score' do
    before do
      student_homework.score = nil
      student_homework.save
    end

    it '1. should not save without homework score' do
      expect(student_homework).not_to be_valid
    end

    it '2. should only have one error' do
      expect(student_homework.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for homework score' do
      expect(student_homework.errors.to_h.keys).to include(:score)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:student) }
    it { is_expected.to belong_to(:quarter) }
    it { is_expected.to belong_to(:quarter_homework) }
  end
end
