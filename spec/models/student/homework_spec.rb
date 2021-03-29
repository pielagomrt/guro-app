require 'rails_helper'

RSpec.describe Student::Homework, type: :model do
  let(:student_homework) { described_class.new }

  before do
    student_homework.score = 20
    student_homework.save
  end

  context 'when saving without homework score' do
    it '1. should not save without homework score' do
      student_homework.score = nil
      student_homework.save
      expect(student_homework).not_to be_valid
    end

    it '2. should only have one error' do
      student_homework.score = nil
      student_homework.save
      expect(student_homework.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for homework score' do
      student_homework.score = nil
      student_homework.save
      expect(student_homework.errors.to_h.keys).to include(:score)
    end
  end
end
