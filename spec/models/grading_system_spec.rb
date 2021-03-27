require 'rails_helper'

RSpec.describe GradingSystem, type: :model do
  let(:grading_system) { described_class.new }

  before do
    grading_system.homework = 20
    grading_system.seatwork = 10
    grading_system.project = 20
    grading_system.exam = 40
    grading_system.attendance = 10
    grading_system.save
  end

  context 'when saving without homework' do
    it '1. should not save without homework' do
      grading_system.homework = nil
      grading_system.save
      expect(grading_system).not_to be_valid
    end

    it '2. should only have one error' do
      grading_system.homework = nil
      grading_system.save
      expect(grading_system.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for homework' do
      grading_system.homework = nil
      grading_system.save
      expect(grading_system.errors.to_h.keys).to include(:homework)
    end
  end

  context 'when saving without seatwork' do
    it '4. should not save without seatwork' do
      grading_system.seatwork = nil
      grading_system.save
      expect(grading_system).not_to be_valid
    end

    it '5. should only have one error' do
      grading_system.seatwork = nil
      grading_system.save
      expect(grading_system.errors.full_messages.length).to eq(1)
    end

    it '6. should only have an error for seatwork' do
      grading_system.seatwork = nil
      grading_system.save
      expect(grading_system.errors.to_h.keys).to include(:seatwork)
    end
  end

  context 'when saving without project' do
    it '7. should not save without project' do
      grading_system.project = nil
      grading_system.save
      expect(grading_system).not_to be_valid
    end

    it '8. should only have one error' do
      grading_system.project = nil
      grading_system.save
      expect(grading_system.errors.full_messages.length).to eq(1)
    end

    it '9. should only have an error for project' do
      grading_system.project = nil
      grading_system.save
      expect(grading_system.errors.to_h.keys).to include(:project)
    end
  end

  context 'when saving without exam' do
    it '10. should not save without exam' do
      grading_system.project = nil
      grading_system.save
      expect(grading_system).not_to be_valid
    end

    it '11. should only have one error' do
      grading_system.exam = nil
      grading_system.save
      expect(grading_system.errors.full_messages.length).to eq(1)
    end

    it '12. should only have an error for exam' do
      grading_system.exam = nil
      grading_system.save
      expect(grading_system.errors.to_h.keys).to include(:exam)
    end
  end

  context 'when saving without attendance' do
    it '13. should not save without attendance' do
      grading_system.attendance = nil
      grading_system.save
      expect(grading_system).not_to be_valid
    end

    it '14. should only have one error' do
      grading_system.attendance = nil
      grading_system.save
      expect(grading_system.errors.full_messages.length).to eq(1)
    end

    it '15. should only have an error for attendance' do
      grading_system.attendance = nil
      grading_system.save
      expect(grading_system.errors.to_h.keys).to include(:attendance)
    end
  end
end
