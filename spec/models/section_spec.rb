require 'rails_helper'

RSpec.describe Section, type: :model do
  let(:section) { described_class.new }

  before do
    section.name = 'Section A'
    section.active_quarter = 1
    section.teacher = create(:teacher)
    section.grading_system = create(:grading_system)
    section.save
  end

  context 'when saving without name' do
    before do
      section.name = nil
      section.save
    end

    it '1. should not save without name' do
      expect(section).not_to be_valid
    end

    it '2. should only have one error' do
      expect(section.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for name' do
      expect(section.errors.to_h.keys).to include(:name)
    end
  end

  context 'when saving without active quarter' do
    before do
      section.active_quarter = nil
      section.save
    end

    it '4. should not save without active quarter' do
      expect(section).not_to be_valid
    end

    it '5. should only have one error' do
      expect(section.errors.full_messages.length).to eq(1)
    end

    it '6. should only have an error for active quarter' do
      expect(section.errors.to_h.keys).to include(:active_quarter)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:teacher) }
    it { is_expected.to belong_to(:grading_system) }
    it { is_expected.to have_many(:students) }
    it { is_expected.to have_many(:quarters) }
  end
end
