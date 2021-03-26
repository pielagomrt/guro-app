class UpdateColumnsOfTeachers < ActiveRecord::Migration[6.0]
  def change
    rename_column :teachers, :firstname, :first_name
    rename_column :teachers, :lastname, :last_name
    remove_column :teachers, :sections, :integer
    remove_column :teachers, :grading_system, :integer

    add_column :teachers, :subject, :string
  end
end
