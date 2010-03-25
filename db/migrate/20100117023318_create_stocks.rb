class CreateStocks < ActiveRecord::Migration
  def self.up
    create_table :stocks do |t|
			t.integer :store_id, :null=>false
      t.timestamps #Last Updated.
    end
    add_foreign_key :stocks, :stores, :dependent=>:delete
  end

  def self.down
	  remove_foreign_key :stocks, :stores
    drop_table :stocks
  end
end
