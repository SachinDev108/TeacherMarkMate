class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
    	t.integer :subscription_type_id
    	t.integer :teacher_id
    	t.integer :no_of_printer
    	t.float :amount
    	t.float :printer_amount
    	t.boolean :status, default: false
    	t.string :payment_type
    	t.string :full_name
    	t.string :email
    	t.text	:address
        t.string :payer_email
        t.string :payer_id
        t.string :txn_id
        t.string :payment_status
        t.datetime :payment_date
        t.float  :total_amount

      t.timestamps
    end
  end
end
