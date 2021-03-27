class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.string :name
      t.integer :active_quarter
      t.belongs_to :teacher, index: true, foreign_key: true
      t.belongs_to :grading_system, index: true, foreign_key: true
      t.timestamps
    end
  end
end
