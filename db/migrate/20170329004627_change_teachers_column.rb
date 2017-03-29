class ChangeTeachersColumn < ActiveRecord::Migration[5.0]
  def change
  	remove_column :schedules, :teachers
  	add_column :schedules, :teachers, :string, array: true, default: '{}'
  end
end
