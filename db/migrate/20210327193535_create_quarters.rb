class CreateQuarters < ActiveRecord::Migration[6.0]
  def change
    create_table :quarters do |t|
      t.integer :sequence
      t.string :school_year
      t.integer :max_attendance
      t.belongs_to :section, index: true, foreign_key: true
      t.timestamps
    end
  end
end
