require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:student) { described_class.new }

  before do
    student.first_name = 'Maria'
    student.last_name = 'Clara'
    student.email = 'mc@example.com'
    student.save
  end

  context 'when saving without first name' do
    it '1. should not save without first name' do
      student.first_name = nil
      student.save
      expect(student).not_to be_valid
    end

    it '2. should only have one error' do
      student.first_name = nil
      student.save
      expect(student.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for first name' do
      student.first_name = nil
      student.save
      expect(student.errors.to_h.keys).to include(:first_name)
    end
  end

  context 'when saving without last name' do
    it '4. should not save without last name' do
      student.last_name = nil
      student.save
      expect(student).not_to be_valid
    end

    it '5. should only have one error' do
      student.last_name = nil
      student.save
      expect(student.errors.full_messages.length).to eq(1)
    end

    it '6. should only have an error for last name' do
      student.last_name = nil
      student.save
      expect(student.errors.to_h.keys).to include(:last_name)
    end
  end

  context 'when saving without email' do
    it '7. should not save without email' do
      student.email = nil
      student.save
      expect(student).not_to be_valid
    end

    it '8. should only have one error' do
      student.email = nil
      student.save
      expect(student.errors.full_messages.length).to eq(1)
    end

    it '9. should only have an error for email' do
      student.email = nil
      student.save
      expect(student.errors.to_h.keys).to include(:email)
    end
  end
end
