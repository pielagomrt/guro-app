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
    it '1. should not save without first name' do
      teacher.first_name = nil
      teacher.save
      expect(teacher).not_to be_valid
    end

    it '2. should only have one error' do
      teacher.first_name = nil
      teacher.save
      expect(teacher.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for first name' do
      teacher.first_name = nil
      teacher.save
      expect(teacher.errors.to_h.keys).to include(:first_name)
    end
  end

  context 'when saving without last name' do
    it '4. should not save without last name' do
      teacher.last_name = nil
      teacher.save
      expect(teacher).not_to be_valid
    end

    it '5. should only have one error' do
      teacher.last_name = nil
      teacher.save
      expect(teacher.errors.full_messages.length).to eq(1)
    end

    it '6. should only have an error for last name' do
      teacher.last_name = nil
      teacher.save
      expect(teacher.errors.to_h.keys).to include(:last_name)
    end
  end

  context 'when saving without email' do
    it '7. should not save without email' do
      teacher.email = nil
      teacher.save
      expect(teacher).not_to be_valid
    end

    it '8. should only have one error' do
      teacher.email = nil
      teacher.save
      expect(teacher.errors.full_messages.length).to eq(1)
    end

    it '9. should only have an error for email' do
      teacher.email = nil
      teacher.save
      expect(teacher.errors.to_h.keys).to include(:email)
    end
  end

  context 'when saving without password' do
    it '10. should not save without password' do
      teacher.password = nil
      teacher.save
      expect(teacher).not_to be_valid
    end

    it '11. should only have one error' do
      teacher.password = nil
      teacher.save
      expect(teacher.errors.full_messages.length).to eq(1)
    end

    it '12. should only have an error for password' do
      teacher.password = nil
      teacher.save
      expect(teacher.errors.to_h.keys).to include(:password)
    end
  end

  context 'when saving without subject' do
    it '13. should not save without subject' do
      teacher.subject = nil
      teacher.save
      expect(teacher).not_to be_valid
    end

    it '14. should only have one error' do
      teacher.subject = nil
      teacher.save
      expect(teacher.errors.full_messages.length).to eq(1)
    end

    it '15. should only have an error for subject' do
      teacher.subject = nil
      teacher.save
      expect(teacher.errors.to_h.keys).to include(:subject)
    end
  end
end
