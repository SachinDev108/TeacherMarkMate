class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
    	t.belongs_to :subject, index: true
      t.belongs_to :child, index: true
      t.timestamps
    end
  end
end
