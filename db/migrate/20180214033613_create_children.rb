class CreateChildren < ActiveRecord::Migration[5.1]
  def change
    create_table :children do |t|
    	t.string :name
    	t.references :teacher, foreign_key: true
      t.timestamps
    end
  end
end
