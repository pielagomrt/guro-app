require 'rails_helper'

RSpec.describe Section, type: :model do
  let(:section) { described_class.new }

  before do
    section.name = 'Section A'
    section.active_quarter = 1
    section.save
  end

  context 'when saving without name' do
    it '1. should not save without name' do
      section.name = nil
      section.save
      expect(section).not_to be_valid
    end

    it '2. should only have one error' do
      section.name = nil
      section.save
      expect(section.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for name' do
      section.name = nil
      section.save
      expect(section.errors.to_h.keys).to include(:name)
    end
  end

  context 'when saving without active quarter' do
    it '4. should not save without active quarter' do
      section.active_quarter = nil
      section.save
      expect(section).not_to be_valid
    end

    it '5. should only have one error' do
      section.active_quarter = nil
      section.save
      expect(section.errors.full_messages.length).to eq(1)
    end

    it '6. should only have an error for active quarter' do
      section.active_quarter = nil
      section.save
      expect(section.errors.to_h.keys).to include(:active_quarter)
    end
  end
end
