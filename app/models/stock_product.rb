class StockProduct < ActiveRecord::Base
	belongs_to :stock
	belongs_to :product, :dependent=>:delete, :validate=>true	
	
	attr_protected :stock_id
	attr_protected :product_id
		
	validates_presence_of :qty
	validates_numericality_of :qty, :greater_than_or_equal_to => 0
	
	validates_associated :product	
	validate :product_name_validation
	
	delegate :store, :to => :stock
	
	before_destroy{|sp| sp.product.destroy	}
	
	def decrease_qty(fqty)
		update_attribute('qty', self.qty - fqty)
	end
	
	def sum_qty(fqty)
		update_attribute('qty', self.qty + fqty)
	end
	
	protected
	def product_name_validation	
		sp ||= stock.stock_products.find(:all, :include=>:product)
		sp.each{|sp|  errors.add_to_base "You already have one #{product.product_name}" if sp.product.product_name.casecmp(product.product_name) == 0}
	end
end
