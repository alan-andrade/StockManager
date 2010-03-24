class Stock < ActiveRecord::Base
	belongs_to :store
	has_many :stock_products, :dependent=>:delete_all, :include=>:product
	has_many :active_products, :class_name=>"StockProduct", :include=>:product, :conditions=>"products.active = 1"
	
	attr_protected :store_id

end
