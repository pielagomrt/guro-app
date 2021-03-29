require 'rails_helper'

RSpec.describe Quarter::Attendance, type: :model do
  let(:quarter_attendance) { described_class.new }

  before do
    quarter_attendance.date = '2020-03-31'
    quarter_attendance.quarter = create(:quarter)
    quarter_attendance.save
  end

  context 'when saving without date' do
    before do
      quarter_attendance.date = nil
      quarter_attendance.save
    end

    it '1. should not save without date' do
      expect(quarter_attendance).not_to be_valid
    end

    it '2. should only have one error' do
      expect(quarter_attendance.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for date' do
      expect(quarter_attendance.errors.to_h.keys).to include(:date)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:quarter) }
    it { is_expected.to have_many(:student_absents) }
  end
end
