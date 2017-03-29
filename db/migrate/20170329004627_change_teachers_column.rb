class ChangeTeachersColumn < ActiveRecord::Migration[5.0]
  def change
  	add_column :schedules, :teachers, :string, array: true, default: []
  end
end
