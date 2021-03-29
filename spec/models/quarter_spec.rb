require 'rails_helper'

RSpec.describe Quarter, type: :model do
  let(:quarter) { described_class.new }

  before do
    quarter.sequence = 1
    quarter.school_year = '2019-2020'
    quarter.max_attendance = 20
    quarter.section = create(:section)
    quarter.save
  end

  context 'when validating sequence' do
    before do
      quarter.sequence = nil
      quarter.save
    end

    it '1. should not save without value' do
      expect(quarter).not_to be_valid
    end

    it '2. should not save without value' do
      expect(quarter.errors.full_messages.length).to eq(1)
    end

    it '3. should not save without value' do
      expect(quarter.errors.to_h.keys).to include(:sequence)
    end
  end

  context 'when validating school_year' do
    before do
      quarter.school_year = nil
      quarter.save
    end

    it '1. should not save without value' do
      expect(quarter).not_to be_valid
    end

    it '2. should not save without value' do
      expect(quarter.errors.full_messages.length).to eq(1)
    end

    it '3. should not save without value' do
      expect(quarter.errors.to_h.keys).to include(:school_year)
    end
  end

  context 'when validating max_attendance' do
    before do
      quarter.max_attendance = nil
      quarter.save
    end

    it '1. should not save without value' do
      expect(quarter).not_to be_valid
    end

    it '2 should not save without value' do
      expect(quarter.errors.full_messages.length).to eq(1)
    end

    it '3. should not save without value' do
      expect(quarter.errors.to_h.keys).to include(:max_attendance)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:section) }
    it { is_expected.to have_many(:homeworks) }
    it { is_expected.to have_many(:seatworks) }
    it { is_expected.to have_many(:projects) }
    it { is_expected.to have_many(:exams) }
    it { is_expected.to have_many(:attendances) }
    it { is_expected.to have_many(:student_homeworks) }
    it { is_expected.to have_many(:student_seatworks) }
    it { is_expected.to have_many(:student_projects) }
    it { is_expected.to have_many(:student_exams) }
    it { is_expected.to have_many(:student_absents) }
  end
end
