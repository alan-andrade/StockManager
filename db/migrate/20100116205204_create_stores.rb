class CreateStores < ActiveRecord::Migration
  def self.up
    create_table :stores do |t|
    	t.string 	:store_name, 		:null=>false
    	t.integer	:user_id,	:null=>false
    	t.timestamps
    end
    	add_foreign_key :stores, :users, :dependent=>:delete
  end


  def self.down
  	remove_foreign_key :stores, :users
    drop_table :stores
  end
end
