module UsersHelper
	def count_products
		products = 0
		@current_user.stores.each do |s|
			products += s.stock.stock_products.count
		end
		products
	end
end
