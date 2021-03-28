class CreateQuarterSeatworks < ActiveRecord::Migration[6.0]
  def change
    create_table :quarter_seatworks do |t|
      t.string :title
      t.integer :max_score
      t.belongs_to :quarter, index: true, foreign_key: true
      t.timestamps
    end
  end
end
