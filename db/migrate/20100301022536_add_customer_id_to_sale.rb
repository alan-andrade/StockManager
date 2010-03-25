class AddCustomerIdToSale < ActiveRecord::Migration
  def self.up
    add_column :sales, :customer_id, :integer
    
    add_foreign_key :sales, :customers
  end

  def self.down
  	remove_foreing_key :sales, :customers
    remove_column :sales, :customer_id
  end
end
