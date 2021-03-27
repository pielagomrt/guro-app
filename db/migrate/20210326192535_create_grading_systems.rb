class CreateGradingSystems < ActiveRecord::Migration[6.0]
  def change
    create_table :grading_systems do |t|
      t.integer :homework
      t.integer :seatwork
      t.integer :project
      t.integer :exam
      t.integer :attendance
      t.integer :total
      t.belongs_to :teacher, index: true, foreign_key: true
      t.timestamps
    end
  end
end
