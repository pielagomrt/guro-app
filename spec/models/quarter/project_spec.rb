require 'rails_helper'

RSpec.describe Quarter::Project, type: :model do
  let(:quarter_project) { described_class.new }

  before do
    quarter_project.title = 'Lorem Ipsum'
    quarter_project.max_score = 80
    quarter_project.quarter = create(:quarter)
    quarter_project.save
  end

  context 'when saving without quarter project title' do
    before do
      quarter_project.title = nil
      quarter_project.save
    end

    it '1. should not save without quarter project title' do
      expect(quarter_project).not_to be_valid
    end

    it '2. should only have one error' do
      expect(quarter_project.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for quarter project title' do
      expect(quarter_project.errors.to_h.keys).to include(:title)
    end
  end

  context 'when saving without quarter project max score' do
    before do
      quarter_project.max_score = nil
      quarter_project.save
    end

    it '1. should not save without quarter project max score' do
      expect(quarter_project).not_to be_valid
    end

    it '2. should only have one error' do
      expect(quarter_project.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for quarter project max score' do
      expect(quarter_project.errors.to_h.keys).to include(:max_score)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:quarter) }
    it { is_expected.to have_many(:student_projects) }
  end
end
