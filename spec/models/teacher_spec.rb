require 'rails_helper'

RSpec.describe Teacher, type: :model do
  let(:teacher) { described_class.new }

  context 'when validating' do
    it '1. should not save without first name' do
      teacher.first_name = nil
      teacher.last_name = 'Doe'
      teacher.email = 'doe@example.com'
      teacher.subject = 'Science'

      expect(teacher).not_to be_valid
    end

    it '2. should not save without last name' do
      teacher.first_name = 'Jane'
      teacher.last_name = nil
      teacher.email = 'doe@example.com'
      teacher.subject = 'Science'

      expect(teacher).not_to be_valid
    end

    it '3. should not save without email' do
      teacher.first_name = 'Jane'
      teacher.last_name = 'Doe'
      teacher.email = nil
      teacher.subject = 'Science'

      expect(teacher).not_to be_valid
    end

    it '4. should not save without subject' do
      teacher.first_name = 'Jane'
      teacher.last_name = 'Doe'
      teacher.email = 'doe@example.com'
      teacher.subject = nil

      expect(teacher).not_to be_valid
    end
  end
end
