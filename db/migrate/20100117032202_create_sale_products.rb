class CreateSaleProducts < ActiveRecord::Migration
  def self.up
    create_table :sale_products do |t|
    	t.references :product	, :null=>false
    	t.references :sale		,	:null=>false
    	t.integer			:qty		, :null=>false, :default=>0
      t.timestamps
    end
    add_foreign_key :sale_products, :products, :dependent=>:delete
    add_foreign_key :sale_products,	:sales	,	:dependent=>:delete
  end

  def self.down
  	remove_foreign_key :sale_products, 	:products
  	remove_foreign_key :sale_products,	:sales
    drop_table :sale_products
  end
end
