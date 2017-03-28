class RenameTypeToKind < ActiveRecord::Migration[5.0]
  def change
  	rename_column :classrooms, :type, :kind
  end
end
