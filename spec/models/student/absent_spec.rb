require 'rails_helper'

RSpec.describe Student::Absent, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:student) }
    it { is_expected.to belong_to(:quarter) }
    it { is_expected.to belong_to(:quarter_attendance) }
  end
end
