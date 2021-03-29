class AssocStudentSeatworksToQuarterSeatworks < ActiveRecord::Migration[6.0]
  def change
    add_reference :student_seatworks, :quarter, foreign_key: true, index: true
    add_reference :student_seatworks, :quarter_seatwork, foreign_key: true, index: true
  end
end
