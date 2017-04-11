class CreateSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :kind
      t.integer :vacancies
      t.integer :inscribed
      t.integer :pending
      t.integer :enrolled
      t.references :classroom, foreign_key: true

      t.timestamps
    end
  end
end
