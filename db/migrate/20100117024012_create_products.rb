class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
			t.string		:product_name	,			:null=>false
			t.decimal		:price,			:null=>false	,	:precision=>8	,	:scale=>2
			t.string			:description
    end
    add_index :products, :product_name    
  end

  def self.down
    drop_table :products
  end
end
