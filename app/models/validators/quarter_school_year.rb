class Validators::QuarterSchoolYear < ActiveModel::Validator
  def validate(record)
    return record.errors.add(:school_year, 'is required') if record.school_year.nil?

    is_correct_format = record.school_year.match?(/^\d{4}-\d{4}$/)
    return record.errors.add(:school_year, 'format should be XXXX-XXXX') unless is_correct_format

    year_left, year_right = record.school_year.split('-')
    return record.errors.add(:school_year, 'has invalid years provided') if year_left > year_right

    return record.errors.add(:school_year, 'has invalid years provided') unless (year_right.to_i - year_left.to_i) == 1
  end
end
