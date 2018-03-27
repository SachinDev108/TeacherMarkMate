class AddFieldsToSubscriptions < ActiveRecord::Migration[5.1]
  def change
  	remove_column :subscriptions, :full_name, :string
  	remove_column :subscriptions, :email, :string
  	remove_column :subscriptions, :address, :text
  	add_column :subscriptions, :no_of_users, :integer
  	add_column :subscriptions, :period, :string
  	add_column :subscription_types, :printer_price, :float
  end
end
