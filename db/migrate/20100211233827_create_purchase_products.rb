class CreatePurchaseProducts < ActiveRecord::Migration
  def self.up
    create_table :purchase_products do |t|
		t.references :purchase, :product
		t.integer 	:qty,	:default=>0, :null=>false
      t.timestamps
    end
    add_foreign_key :purchase_products	,	:products
    
  end

  def self.down
	remove_foreign_key :purchase_products	,	:products
    drop_table :purchase_products
  end
end
