require 'rails_helper'

RSpec.describe Quarter::Homework, type: :model do
  let(:quarter_homework) { described_class.new }

  before do
    quarter_homework.title = 'Lorem Ipsum'
    quarter_homework.max_score = 80
    quarter_homework.save
  end

  context 'when saving without quarter homework title' do
    it '1. should not save without quarter homework title' do
      quarter_homework.title = nil
      quarter_homework.save
      expect(quarter_homework).not_to be_valid
    end

    it '2. should only have one error' do
      quarter_homework.title = nil
      quarter_homework.save
      expect(quarter_homework.errors.full_messages.length).to eq(1)
    end

    it '3. should only have an error for quarter homework title' do
      quarter_homework.title = nil
      quarter_homework.save
      expect(quarter_homework.errors.to_h.keys).to include(:title)
    end
  end

  context 'when saving without quarter homework max score' do
    it '4. should not save without quarter homework max score' do
      quarter_homework.max_score = nil
      quarter_homework.save
      expect(quarter_homework).not_to be_valid
    end

    it '5. should only have one error' do
      quarter_homework.max_score = nil
      quarter_homework.save
      expect(quarter_homework.errors.full_messages.length).to eq(1)
    end

    it '6. should only have an error for quarter homework max score' do
      quarter_homework.max_score = nil
      quarter_homework.save
      expect(quarter_homework.errors.to_h.keys).to include(:max_score)
    end
  end
end
