require 'rails_helper'

RSpec.describe Student::Seatwork, type: :model do
  let(:student_seatwork) { described_class.new }

  before do
    student_seatwork.score = 20
    student_seatwork.student = create(:student)
    student_seatwork.quarter = create(:quarter)
    student_seatwork.quarter_seatwork = create(:quarter_seatwork)
    student_seatwork.save
  end

  context 'when saving without seatwork score' do
    before do
      student_seatwork.score = nil
      student_seatwork.save
    end

    it '1. should not save without seatwork score' do
      expect(student_seatwork).not_to be_valid
    end

    it '2. should only have one error' do
      expect(student_seatwork.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for seatwork score' do
      expect(student_seatwork.errors.to_h.keys).to include(:score)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:student) }
    it { is_expected.to belong_to(:quarter) }
    it { is_expected.to belong_to(:quarter_seatwork) }
  end
end
