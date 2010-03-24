class StockProductObserver < ActiveRecord::Observer
	def before_update(product)
		if product.qty < 5
			UserMailer.deliver_low_stock!(product.stock.store.user, product)
		end
	end
end
