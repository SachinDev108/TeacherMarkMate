class CreateRecurrings < ActiveRecord::Migration[5.1]
  def change
    create_table :recurrings do |t|
    	t.string :subscr_id
    	t.string :txn_type
    	t.datetime :subscr_date
    	t.string :period3
    	t.integer :subscription_id
      t.timestamps
    end
  end
end
