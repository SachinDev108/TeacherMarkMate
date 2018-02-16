class CreateDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :details do |t|
    	t.string :comment
    	t.integer :grade_id
    	t.integer :sheet_id
    	t.integer :child_id
      t.timestamps
    end
  end
end
