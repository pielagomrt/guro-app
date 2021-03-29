require 'rails_helper'

RSpec.describe GradingSystem, type: :model do
  let(:grading_system) { described_class.new }

  before do
    grading_system.homework = 20
    grading_system.seatwork = 10
    grading_system.project = 20
    grading_system.exam = 40
    grading_system.attendance = 10
    grading_system.teacher = create(:teacher)
    grading_system.save
  end

  context 'when saving without homework' do
    before do
      grading_system.homework = nil
      grading_system.save
    end

    it '1. should not save without homework' do
      expect(grading_system).not_to be_valid
    end

    it '2. should only have two errors' do
      expect(grading_system.errors.full_messages.length).to eq(2)
    end

    it '3. should have an error for homework' do
      expect(grading_system.errors.to_h.keys).to include(:homework)
    end

    it '4. should also have an error for total' do
      expect(grading_system.errors.to_h.keys).to include(:total)
    end
  end

  context 'when saving without seatwork' do
    before do
      grading_system.seatwork = nil
      grading_system.save
    end

    it '1. should not save without seatwork' do
      expect(grading_system).not_to be_valid
    end

    it '2. should only have two errors' do
      expect(grading_system.errors.full_messages.length).to eq(2)
    end

    it '3. should have an error for seatwork' do
      expect(grading_system.errors.to_h.keys).to include(:seatwork)
    end

    it '4. should also have an error for total' do
      expect(grading_system.errors.to_h.keys).to include(:total)
    end
  end

  context 'when saving without project' do
    before do
      grading_system.project = nil
      grading_system.save
    end

    it '1. should not save without project' do
      expect(grading_system).not_to be_valid
    end

    it '2. should only have two errors' do
      expect(grading_system.errors.full_messages.length).to eq(2)
    end

    it '3. should have an error for project' do
      expect(grading_system.errors.to_h.keys).to include(:project)
    end

    it '4. should also have an error for total' do
      expect(grading_system.errors.to_h.keys).to include(:total)
    end
  end

  context 'when saving without exam' do
    before do
      grading_system.exam = nil
      grading_system.save
    end

    it '1. should not save without exam' do
      expect(grading_system).not_to be_valid
    end

    it '2. should only have two errors' do
      expect(grading_system.errors.full_messages.length).to eq(2)
    end

    it '3. should have an error for exam' do
      expect(grading_system.errors.to_h.keys).to include(:exam)
    end

    it '4. should also have an error for total' do
      expect(grading_system.errors.to_h.keys).to include(:total)
    end
  end

  context 'when saving without attendance' do
    before do
      grading_system.attendance = nil
      grading_system.save
    end

    it '1. should not save without attendance' do
      expect(grading_system).not_to be_valid
    end

    it '2. should only have two errors' do
      expect(grading_system.errors.full_messages.length).to eq(2)
    end

    it '3. should have an error for attendance' do
      expect(grading_system.errors.to_h.keys).to include(:attendance)
    end

    it '4. should also have an error for total' do
      expect(grading_system.errors.to_h.keys).to include(:total)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:teacher) }
    it { is_expected.to have_many(:sections) }
  end
end
