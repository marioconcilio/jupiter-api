class MakeSubjectNullable < ActiveRecord::Migration[5.0]
  def change
  	change_column_null :classrooms, :subject_id, true
  end
end
