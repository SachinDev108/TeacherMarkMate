class AddAddressToTeachers < ActiveRecord::Migration[5.1]
  def change
  	add_column :teachers, :address, :text
  end
end
