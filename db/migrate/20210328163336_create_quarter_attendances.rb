class CreateQuarterAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :quarter_attendances do |t|
      t.date :date
      t.belongs_to :quarter, index: true, foreign_key: true
      t.timestamps
    end
  end
end
