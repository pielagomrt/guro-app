require 'rails_helper'

RSpec.describe Quarter::Exam, type: :model do
  let(:quarter_exam) { described_class.new }

  before do
    quarter_exam.title = 'Lorem Ipsum'
    quarter_exam.max_score = 80
    quarter_exam.quarter = create(:quarter)
    quarter_exam.save
  end

  context 'when saving without quarter exam title' do
    before do
      quarter_exam.title = nil
      quarter_exam.save
    end

    it '1. should not save without quarter exam title' do
      expect(quarter_exam).not_to be_valid
    end

    it '2. should only have one error' do
      expect(quarter_exam.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for quarter exam title' do
      expect(quarter_exam.errors.to_h.keys).to include(:title)
    end
  end

  context 'when saving without quarter exam max score' do
    before do
      quarter_exam.max_score = nil
      quarter_exam.save
    end

    it '1. should not save without quarter exam max score' do
      expect(quarter_exam).not_to be_valid
    end

    it '2. should only have one error' do
      expect(quarter_exam.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for quarter exam max score' do
      expect(quarter_exam.errors.to_h.keys).to include(:max_score)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:quarter) }
    it { is_expected.to have_many(:student_exams) }
  end
end
