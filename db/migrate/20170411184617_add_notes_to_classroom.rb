class AddNotesToClassroom < ActiveRecord::Migration[5.0]
  def change
    add_column :classrooms, :notes, :string
  end
end
