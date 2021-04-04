require 'rails_helper'

RSpec.describe Teacher, type: :model do
  let(:teacher) { described_class.new }

  before do
    teacher.first_name = 'Jane'
    teacher.last_name = 'Doe'
    teacher.email = 'doe@example.com'
    teacher.password = '12345678'
    teacher.subject = 'Science'
    teacher.save
  end

  context 'when saving without first name' do
    before do
      teacher.first_name = nil
      teacher.save
    end

    it '1. should not save without first name' do
      expect(teacher).not_to be_valid
    end

    it '2. should only have one error' do
      expect(teacher.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for first name' do
      expect(teacher.errors.to_h.keys).to include(:first_name)
    end
  end

  context 'when saving without last name' do
    before do
      teacher.last_name = nil
      teacher.save
    end

    it '1. should not save without last name' do
      expect(teacher).not_to be_valid
    end

    it '2. should only have one error' do
      expect(teacher.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for last name' do
      expect(teacher.errors.to_h.keys).to include(:last_name)
    end
  end

  context 'when saving without email' do
    before do
      teacher.email = nil
      teacher.save
    end

    it '1. should not save without email' do
      expect(teacher).not_to be_valid
    end

    it '2. should only have one error' do
      expect(teacher.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for email' do
      expect(teacher.errors.to_h.keys).to include(:email)
    end
  end

  # context 'when saving without password' do
  #   before do
  #     teacher.password = nil
  #     teacher.save
  #   end

  #   it '1. should not save without password' do
  #     expect(teacher).not_to be_valid
  #   end

  #   it '2. should only have one error' do
  #     expect(teacher.errors.full_messages.length).to eq(1)
  #   end

  #   it '3. should only have an error for password' do
  #     expect(teacher.errors.to_h.keys).to include(:password)
  #   end
  # end

  context 'when saving without subject' do
    before do
      teacher.subject = nil
      teacher.save
    end

    it '1. should not save without subject' do
      expect(teacher).not_to be_valid
    end

    it '2. should only have one error' do
      expect(teacher.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for subject' do
      expect(teacher.errors.to_h.keys).to include(:subject)
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:grading_systems) }
    it { is_expected.to have_many(:sections) }
  end
end
