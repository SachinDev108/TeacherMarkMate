class AddroleFromTechers < ActiveRecord::Migration[5.1]
  def change
  	add_column :teachers, :role, :string
  	add_column :teachers, :admin_id, :integer
  	add_column :teachers, :parent_id, :integer
  end
end
