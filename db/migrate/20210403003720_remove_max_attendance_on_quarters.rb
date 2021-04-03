class RemoveMaxAttendanceOnQuarters < ActiveRecord::Migration[6.0]
  def change
    remove_column :quarters, :max_attendance, :integer
  end
end
