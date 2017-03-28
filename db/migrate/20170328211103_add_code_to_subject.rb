class AddCodeToSubject < ActiveRecord::Migration[5.0]
  def change
    add_column :subjects, :code, :string
  end
end
