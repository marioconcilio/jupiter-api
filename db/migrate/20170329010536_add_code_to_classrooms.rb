class AddCodeToClassrooms < ActiveRecord::Migration[5.0]
  def change
  	add_column :classrooms, :code, :string
  end
end
