require 'rails_helper'

RSpec.describe Quarter::Seatwork, type: :model do
  let(:quarter_seatwork) { described_class.new }

  before do
    quarter_seatwork.title = 'Lorem Ipsum'
    quarter_seatwork.max_score = 80
    quarter_seatwork.save
  end

  context 'when saving without quarter seatwork title' do
    it '1. should not save without quarter seatwork title' do
      quarter_seatwork.title = nil
      quarter_seatwork.save
      expect(quarter_seatwork).not_to be_valid
    end

    it '2. should only have one error' do
      quarter_seatwork.title = nil
      quarter_seatwork.save
      expect(quarter_seatwork.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for quarter seatwork title' do
      quarter_seatwork.title = nil
      quarter_seatwork.save
      expect(quarter_seatwork.errors.to_h.keys).to include(:title)
    end
  end

  context 'when saving without quarter seatwork max score' do
    it '4. should not save without quarter seatwork max score' do
      quarter_seatwork.max_score = nil
      quarter_seatwork.save
      expect(quarter_seatwork).not_to be_valid
    end

    it '5. should only have one error' do
      quarter_seatwork.max_score = nil
      quarter_seatwork.save
      expect(quarter_seatwork.errors.full_messages.length).to eq(1)
    end

    it '6. should only have an error for quarter seatwork max score' do
      quarter_seatwork.max_score = nil
      quarter_seatwork.save
      expect(quarter_seatwork.errors.to_h.keys).to include(:max_score)
    end
  end
end
