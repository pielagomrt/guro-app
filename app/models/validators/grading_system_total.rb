class Validators::GradingSystemTotal < ActiveModel::Validator
  def validate(record)
    requirements = %w[homework seatwork project exam attendance]
    grades_system = record.attributes.select { |key, value| (requirements.include? key and !value.nil?) }

    return record.errors.add(:total, 'should be equal to 100') unless grades_system.values.sum == 100
  end
end
