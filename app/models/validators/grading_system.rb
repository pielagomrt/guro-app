class Validators::GradingSystem < ActiveModel::Validator
  def validate(record)
    return unless record.new_record?

    grades_system = record.attributes.values.compact
    return record.errors.add(:total, 'should be equal to 100') unless grades_system.sum == 100
  end
end
