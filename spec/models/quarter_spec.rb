require 'rails_helper'

RSpec.describe Quarter, type: :model do
  let(:quarter) { described_class.new }

  before do
    quarter.sequence = 1
    quarter.school_year = '2019-2020'
    quarter.max_attendance = 20
    quarter.save
  end

  context 'when validating sequence' do
    it '1. should not save without value' do
      quarter.sequence = nil
      quarter.save
      expect(quarter).not_to be_valid
    end

    it '2. should not save without value' do
      quarter.sequence = nil
      quarter.save
      expect(quarter.errors.full_messages.length).to eq(1)
    end

    it '3. should not save without value' do
      quarter.sequence = nil
      quarter.save
      expect(quarter.errors.to_h.keys).to include(:sequence)
    end
  end

  context 'when validating school_year' do
    it '4. should not save without value' do
      quarter.school_year = nil
      quarter.save
      expect(quarter).not_to be_valid
    end

    it '5 should not save without value' do
      quarter.school_year = nil
      quarter.save
      expect(quarter.errors.full_messages.length).to eq(1)
    end

    it '6. should not save without value' do
      quarter.school_year = nil
      quarter.save
      expect(quarter.errors.to_h.keys).to include(:school_year)
    end
  end

  context 'when validating max_attendance' do
    it '7. should not save without value' do
      quarter.max_attendance = nil
      quarter.save
      expect(quarter).not_to be_valid
    end

    it '8 should not save without value' do
      quarter.max_attendance = nil
      quarter.save
      expect(quarter.errors.full_messages.length).to eq(1)
    end

    it '9. should not save without value' do
      quarter.max_attendance = nil
      quarter.save
      expect(quarter.errors.to_h.keys).to include(:max_attendance)
    end
  end
end
