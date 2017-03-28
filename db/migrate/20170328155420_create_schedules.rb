class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.string :week_day
      t.time :time_begin
      t.time :time_end
      t.string :teachers
      t.references :classroom, foreign_key: true

      t.timestamps
    end
  end
end
