require 'rails_helper'

RSpec.describe Quarter::Seatwork, type: :model do
  let(:quarter_seatwork) { described_class.new }

  before do
    quarter_seatwork.title = 'Lorem Ipsum'
    quarter_seatwork.max_score = 80
    quarter_seatwork.quarter = create(:quarter)
    quarter_seatwork.save
  end

  context 'when saving without quarter seatwork title' do
    before do
      quarter_seatwork.title = nil
      quarter_seatwork.save
    end

    it '1. should not save without quarter seatwork title' do
      expect(quarter_seatwork).not_to be_valid
    end

    it '2. should only have one error' do
      expect(quarter_seatwork.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for quarter seatwork title' do
      expect(quarter_seatwork.errors.to_h.keys).to include(:title)
    end
  end

  context 'when saving without quarter seatwork max score' do
    before do
      quarter_seatwork.max_score = nil
      quarter_seatwork.save
    end

    it '1. should not save without quarter seatwork max score' do
      expect(quarter_seatwork).not_to be_valid
    end

    it '2. should only have one error' do
      expect(quarter_seatwork.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for quarter seatwork max score' do
      expect(quarter_seatwork.errors.to_h.keys).to include(:max_score)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:quarter) }
    it { is_expected.to have_many(:student_seatworks) }
  end
end
