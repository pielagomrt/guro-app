require 'rails_helper'

RSpec.describe Quarter, type: :model do
  let(:quarter) { described_class.new }

  before do
    quarter.sequence = 1
    quarter.school_year = '2019-2020'
    quarter.section = create(:section)
    quarter.save
  end

  context 'when saving sequence beyond inclusion validation' do
    before do
      quarter.sequence = 0
      quarter.save
    end

    it '1. should not save a value more than 4' do
      quarter.sequence = 5
      quarter.save
      expect(quarter).not_to be_valid
    end

    it '2. should not save a value less than 1' do
      expect(quarter).not_to be_valid
    end

    it '3. should only have one error' do
      expect(quarter.errors.full_messages.length).to eq(1)
    end

    it '4. should only have an error for active quarter' do
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
