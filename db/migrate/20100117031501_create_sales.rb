class CreateSales < ActiveRecord::Migration
  def self.up
    create_table :sales do |t|
    	t.references	:store	,	:null=>false
    	
      t.timestamps
    end
    add_foreign_key :sales, :stores, :dependent => :delete
  end

  def self.down
	  remove_foreign_key :sales, :stores
    drop_table :sales
  end
end
