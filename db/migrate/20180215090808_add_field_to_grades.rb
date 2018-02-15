class AddFieldToGrades < ActiveRecord::Migration[5.1]
  def change
  	add_column :grades, :abr, :string 
  end
end
