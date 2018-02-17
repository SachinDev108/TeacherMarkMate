class AddDateToSheets < ActiveRecord::Migration[5.1]
  def change
    add_column :sheets, :date, :datetime
  end
end
