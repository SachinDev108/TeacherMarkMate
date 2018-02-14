class CreateGrades < ActiveRecord::Migration[5.1]
  def change
    create_table :grades do |t|
    	t.string :name
    	t.integer :marks
    	t.references :subject, foreign_key: true
      t.timestamps
    end
  end
end
