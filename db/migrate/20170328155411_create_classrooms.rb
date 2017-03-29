class CreateClassrooms < ActiveRecord::Migration[5.0]
  def change
    create_table :classrooms do |t|
      t.string :code
      t.date :date_begin
      t.date :date_end
      t.string :kind
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
