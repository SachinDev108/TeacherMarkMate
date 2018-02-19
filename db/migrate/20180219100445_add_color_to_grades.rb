class AddColorToGrades < ActiveRecord::Migration[5.1]
  def change
    add_column :grades, :color, :string
  end
end
