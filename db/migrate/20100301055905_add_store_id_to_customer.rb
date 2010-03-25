class AddStoreIdToCustomer < ActiveRecord::Migration
  def self.up
    add_column :customers, :store_id, :integer
  end

  def self.down
    remove_column :customers, :store_id
  end
end
