class CreateSheets < ActiveRecord::Migration[5.1]
  def change
    create_table :sheets do |t|
    	t.string :title
    	t.integer :subject_id
    	t.references :teacher, foreign_key: true
      t.timestamps
    end
  end
end
