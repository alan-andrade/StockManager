class PurchaseProduct < ActiveRecord::Base
	belongs_to :purchase
	belongs_to :product	
	
	after_create { |pp| pp.product.stock_product.sum_qty(pp.qty) }
end
