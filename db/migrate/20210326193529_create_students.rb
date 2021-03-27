class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.belongs_to :section, index: true, foreign_key: true
      t.timestamps
    end
  end
end
