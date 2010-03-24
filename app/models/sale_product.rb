class SaleProduct < ActiveRecord::Base
	belongs_to :product
	belongs_to :sale
	
	#attr_protected :product_id
	#attr_protected :sale	
	
	before_create 	{|sp| sp.product.stock_product.decrease_qty(sp.qty)}
	before_destroy 	{|sp| sp.product.stock_product.sum_qty(sp.qty)}
end
