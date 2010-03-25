class CreateStockProducts < ActiveRecord::Migration
  def self.up
    create_table :stock_products do |t|
    	t.integer	:stock_id		,	:null=>false
    	t.integer	:product_id	,	:null=>false
    	t.integer			:qty		,	:null=>false	
      t.timestamps # Last Sale
    end
    add_foreign_key :stock_products	, :stocks, :dependent=>:delete
    add_foreign_key :stock_products	,	:products, :dependent=>:delete		
    
  end

  def self.down
  	remove_foreign_key :stock_products, :stocks
  	remove_foreign_key :stock_products,	:products
    drop_table :stock_products
  end
end
