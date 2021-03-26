class AddColumnsToTeachers < ActiveRecord::Migration[6.0]
  def change
    add_column :teachers, :firstname, :string
    add_column :teachers, :lastname, :string
    add_column :teachers, :sections, :integer
    add_column :teachers, :grading_system, :integer
  end
end
