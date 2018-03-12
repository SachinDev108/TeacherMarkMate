class CreateSubscriptionTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :subscription_types do |t|
    	t.string :name
    	t.float :price
    	t.float :yearly_price
    	t.integer :no_of_printers
    	t.integer :sort_order
    	t.string :description
      t.timestamps
    end
  end
end
