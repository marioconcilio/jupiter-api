class AddNameToClassroom < ActiveRecord::Migration[5.0]
  def change
    add_column :classrooms, :name, :string
  end
end
