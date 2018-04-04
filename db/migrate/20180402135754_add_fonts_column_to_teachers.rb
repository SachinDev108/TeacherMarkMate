class AddFontsColumnToTeachers < ActiveRecord::Migration[5.1]
  def change
  	add_column :teachers, :font_name, :string
  	add_column :teachers, :font_size, :string
  end
end
