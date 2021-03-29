require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:student) { described_class.new }

  before do
    student.first_name = 'Maria'
    student.last_name = 'Clara'
    student.email = 'mc@example.com'
    student.section = create(:section)
    student.save
  end

  context 'when saving without first name' do
    before do
      student.first_name = nil
      student.save
    end

    it '1. should not save without first name' do
      expect(student).not_to be_valid
    end

    it '2. should only have one error' do
      expect(student.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for first name' do
      expect(student.errors.to_h.keys).to include(:first_name)
    end
  end

  context 'when saving without last name' do
    before do
      student.last_name = nil
      student.save
    end

    it '1. should not save without last name' do
      expect(student).not_to be_valid
    end

    it '2. should only have one error' do
      expect(student.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for last name' do
      expect(student.errors.to_h.keys).to include(:last_name)
    end
  end

  context 'when saving without email' do
    before do
      student.email = nil
      student.save
    end

    it '1. should not save without email' do
      expect(student).not_to be_valid
    end

    it '2. should only have one error' do
      expect(student.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for email' do
      expect(student.errors.to_h.keys).to include(:email)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:section) }
    it { is_expected.to have_many(:homeworks) }
    it { is_expected.to have_many(:seatworks) }
    it { is_expected.to have_many(:projects) }
    it { is_expected.to have_many(:exams) }
    it { is_expected.to have_many(:absents) }
  end
end
